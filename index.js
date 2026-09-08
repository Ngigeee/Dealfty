const express = require("express");
const http = require("http");
const path = require("path");
const bcrypt = require("bcrypt");
const crypto = require("crypto");
const session=require("express-session");
const expressLayouts = require("express-ejs-layouts");
const {validateInputs,sendVerificationEmail,requireAuth,formatFullDate,getTimeOfDay} = require("./routes/utils/functions");
const db = require("./routes/config");


const registerRoutes = require("./routes/register")(db);
const loginRoutes = require("./routes/login")(db);
const listingsRoutes = require("./routes/products")(db);
const reviewsRoutes = require("./routes/reviews")(db);
const chatModule = require("./routes/handle_messages");
const transportModule = require("./routes/handle_transport"); 
const barterModule = require("./routes/handle_barter");  // path to your chat.js
const professionalsModule = require("./routes/handle_professionals"); 
//business routes
const businessloginRoutes = require("./routes/businessAccount/login")(db);
const uploadRoutes = require("./routes/businessAccount/uploadProduct");
const serviceRoutes = require("./routes/businessAccount/uploadService");
const transportRoutes = require("./routes/businessAccount/transport");
const ordersRoutes = require("./routes/businessAccount/business_orders");
const messagesRoutes = require("./routes/businessAccount/messages");
const profileRoutes = require("./routes/businessAccount/profile");
const settingsRoutes = require("./routes/businessAccount/settings");
//help do database queries
const { queryDB } = require("./routes/utils/dbHelpers");

//business api routes
//handle all dashboard
const { getcountListingsofLoggedIN, markMessagesAsRead } = require("./routes/utils/getAlllistings");

const app = express();

const server = http.createServer(app);

// ✅ Middleware
app.use(express.static(path.join(__dirname, "public")));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
const sessionMiddleware=session({
secret: 'your-secret-key',  // change this to a secure random string
  resave: false,
  saveUninitialized: false,
  cookie: { maxAge: 1000 * 60 * 60 * 24 } // 1 day

});
app.use((req, res, next) => {
  res.locals.userName = req.session?.user_name || null;
  res.locals.user_id = req.session?.user_id || null;
  next();
});


// 2️⃣ Use it with Express
app.use(sessionMiddleware);
// ✅ View engine
app.set("view engine", "ejs");
app.use(expressLayouts);

// ✅ Default layout
app.set("layout", "layouts/mainLayout");

// --- Chat module ---
// Chat module
const { chatApp, io } = chatModule(db, sessionMiddleware, server);
//business routes
app.use("/business", businessloginRoutes);
app.use("/", transportModule);
app.use("/", barterModule);
app.use("/", professionalsModule);


//individual account routes
app.use("/", uploadRoutes);
app.use("/", serviceRoutes);
app.use("/", settingsRoutes);
app.use("/", messagesRoutes);
app.use("/", ordersRoutes);
app.use("/", transportRoutes);
app.use("/", registerRoutes);
app.use("/", loginRoutes);
app.use("/", profileRoutes);
app.use("/", listingsRoutes);
app.use("/", reviewsRoutes);
app.use("/chat", chatApp);
// ==========================================
// ✅ BUSINESS USER ROUTES (PAGES)
// ==========================================
app.get("/business/login", (req, res) => {
  res.render("businessAccount/business_login", { layout:"businessAccount/layouts/signLayout" });
});
app.get("/business/chat", (req, res) => {
  res.render("businessAccount/business_chat",{ userName: req.session.user_name ,user_id:req.session.user_id,title: ""});
});

app.get("/business/dashboard",requireAuth, async (req, res) => {
const userId=req.session.user_id;
const stats = await getcountListingsofLoggedIN(userId);
const now = new Date();
const week_bars = [2, 5, 1, 3, 4, 6, 2];
const week_labels = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"];
const max_bars = Math.max(...week_bars);
// ✅ define emoji map HERE
  const cat_emoji = {
    tech: "💻",
    transport: "🚛",
    beauty: "💄",
    home: "🏠",
    fashion: "👕"
  };

  res.render("businessAccount/business_dashboard", { cat_emoji,max_bars,week_labels,week_bars,stats,userName: req.session.user_name,current_date: formatFullDate(now),time_of_day: getTimeOfDay(now),layout:"businessAccount/layouts/businessmainLayout" });
});

app.get("/business/analytics",requireAuth, async (req, res) => {
  const userId = req.session.user_id;
  const now = new Date();

  const statsRaw = await getcountListingsofLoggedIN(userId);

  // -----------------------------
  // FIX 1: map stats to EJS names
  // -----------------------------
  const stats = {
    listings: statsRaw.listing_count,
    active: statsRaw.active,
    orders: statsRaw.orders_count,
    messages: statsRaw.messages_count
  };

  // -----------------------------
  // FIX 2: category mapping
  // stats.category = [{ category, cnt }]
  // -----------------------------
  const by_category = statsRaw.category || [];

  // -----------------------------
  // FIX 3: chart data (7 days)
  // replace hardcoded arrays later if needed
  // -----------------------------
  const days_data = [2, 5, 1, 3, 4, 6, 2];
  const labels = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  const max_v = Math.max(...days_data, 1);

  const msg_data = [1, 3, 0, 2, 5, 4, 2];
  const msg_labels = labels;
  const msg_max = Math.max(...msg_data, 1);

  res.render("businessAccount/business_analytics", {
    layout: "businessAccount/layouts/businessmainLayout",

    stats,
    by_category,

    // charts (MATCH EJS EXACTLY)
    days_data,
    labels,
    max_v,

    msg_data,
    msg_labels,
    msg_max,

    userName: req.session.user_name,
    current_date: formatFullDate(now),
    time_of_day: getTimeOfDay(now)
  });
});

app.get("/business/listings",requireAuth, async (req, res) => {
  try {
    const userId = req.session.user_id;

    const {
      filter = "all",
      type = "all",
      q = ""
    } = req.query;

    // reuse your analytics function OR create listing stats
    const stats = await getcountListingsofLoggedIN(userId);

    const listings = await queryDB(
      `SELECT * FROM listings WHERE user_id = ? ORDER BY created_at DESC`,
      [userId]
    );

    const cat_emoji = {
      tech: "💻",
      transport: "🚛",
      beauty: "💄",
      home: "🏠",
      fashion: "👕"
    };

    res.render("businessAccount/business_listings", {
      layout: "businessAccount/layouts/businessmainLayout",
      stats,
      listings,
      userName: req.session.user_name ,
      cat_emoji,
      search: q,
      filter,
      type,
      deleted: req.query.deleted,
      posted: req.query.posted
    });

  } catch (err) {
    console.error(err);
    res.status(500).send("Listings error");
  }
});

app.get("/business/add-product",requireAuth, (req, res) => {
  res.render("businessAccount/business_post_item", { userName: req.session.user_name ,layout:"businessAccount/layouts/businessmainLayout" });
});

app.get("/business/add-service",requireAuth, (req, res) => {
  res.render("businessAccount/business_add_service", { userName: req.session.user_name ,layout:"businessAccount/layouts/businessmainLayout" });
});
app.get("/business/add-transport", (req, res) => {
  res.render("businessAccount/business_add_transport", { userName: req.session.user_name ,layout:"businessAccount/layouts/businessmainLayout" });
});
app.get("/business/orders", (req, res) => {
  res.render("businessAccount/business_orders", {userName: req.session.user_name , layout:"businessAccount/layouts/businessmainLayout" });
});

app.get("/business/messages", (req, res) => {
  res.render("businessAccount/business_messages", {userName: req.session.user_name , layout:"businessAccount/layouts/businessmainLayout" });
});
app.get("/business/marketplace", (req, res) => {
  res.render("businessAccount/business_marketplace", { userName: req.session.user_name ,layout:"businessAccount/layouts/businessmainLayout" });
});
app.get("/business/profile", (req, res) => {
  res.render("businessAccount/business_profile", { userName: req.session.user_name ,layout:"businessAccount/layouts/businessmainLayout" });
});
app.get("/business/settings", (req, res) => {
  res.render("businessAccount/business_settings", { userName: req.session.user_name ,layout:"businessAccount/layouts/businessmainLayout" });
});
// ==========================================
// ✅ NORMAL USER ROUTES (PAGES)
// ==========================================
app.get("/unauthorized", (req, res) => {
  res.render("unauthorized", { layout: false });
});
app.get("/", (req, res) => {
  res.render("login", { layout: "layouts/signLayout" });
});


app.get("/login", (req, res) => {
  res.render("login", { 
    layout: "layouts/signLayout",
  });
});

app.get("/register", (req, res) => {
  res.render("register", { 
    layout: "layouts/signLayout",
  });
});

app.get("/verify_sent", (req, res) => {
  const email = req.query.email;

  res.render("verify_sent",{
    layout: "layouts/signLayout",
    email,
    });
});


app.get("/verify", (req, res) => {
  const email = req.query.email;
  res.render("verify", {
    layout: "layouts/signLayout",
    email,
    title: "Verify Email",
  });
});

app.get("/home", (req, res) => {
  res.render("home", { userName: req.session.user_name ,title: ""});
});

app.get("/product_details", (req, res) => {
  res.render("products_details",{ userName: req.session.user_name ,title: ""});
});

app.get("/chat", (req, res) => {
  res.render("chat",{ userName: req.session.user_name ,user_id:req.session.user_id,title: ""});
});

app.get("/services", (req, res) => {
  res.render("services",{ userName: req.session.user_name ,user_id:req.session.user_id,title: ""});
});

app.get("/market", (req, res) => {
  res.render("marketplace",{ userName: req.session.user_name ,user_id:req.session.user_id,title: ""});
});

app.get("/barter", (req, res) => {
  res.render("barter",{ userName:req.session.user_name ,user_id:req.session.user_id,title: ""});
});

app.get("/transport", (req, res) => {
  res.render("transport",{ userName: req.session.user_name ,user_id:req.session.user_id,title: ""});
});

app.get("/professionals", (req, res) => {
  res.render("professionals", {
    userName: req.session?.user_name || null,
    user_id: req.session?.user_id || null,
    title: ""
  });
});
//handle services
// Get services with filters
app.get("/api/services", (req, res) => {
    const servicesSQL = "SELECT * FROM listings WHERE type = ?";
    
    db.query(servicesSQL, ["service"], (err, results) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: "Error getting services" });
        }

        // Optional: parse images for thumbnail
        const services = results.map(row => {
            let thumb = row.image;
            try {
                const images = row.images ? JSON.parse(row.images) : [];
                if (images.length) thumb = images[0];
            } catch (_) {}
            return { ...row, thumb };
        });

        // ✅ Send JSON response
        res.json(services);
    });
});
// Get service categories
app.get('/services/categories', (req, res) => {
    const categories = [
        { key: 'home', label: 'Home Services', icon: '🔨', color: 'white' },
        { key: 'skilled', label: 'Skilled Pros', icon: '👷', color: 'white' },
        { key: 'transport', label: 'Transport', icon: '🚛', color: 'white' },
        { key: 'tech', label: 'Tech & IT', icon: '🎧', color: 'white' },
        { key: 'beauty', label: 'Beauty & Health', icon: '💆', color: 'white' },
        { key: 'tutoring', label: 'Tutoring', icon: '🎓', color: 'white' },
        { key: 'business', label: 'Business', icon: '💼', color: 'white' },
        { key: '', label: 'More', icon: '⊞', color: 'grey' },
    ];
    res.json({ categories });
});




///business account api
app.get("/business/get_dashboard_cards",requireAuth, async (req, res) => {
  try {
    const userId = req.session.user_id;

    const data = await getcountListingsofLoggedIN(userId);

    return res.json(data); // 🔥 THIS WAS MISSING
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: "Server error" });
  }
});


//mark read messages
  app.post("/mark-read", async (req, res) => {
  try {
    const loggedInUser = req.session.user_id;
    const { otherUserId, listingId } = req.body;

    if (!loggedInUser) return res.status(401).json({ error: "Unauthorized" });
    if (!otherUserId || !listingId) {
      return res.status(400).json({ error: "Missing data" });
    }

    await markMessagesAsRead(loggedInUser, otherUserId, listingId);

    res.json({ success: true });

  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Server error" });
  }
});
// ==========================================
// ✅ START SERVER
// ==========================================
server.listen(3000, "0.0.0.0", () => {
  console.log("Server running on port 3000");
});
