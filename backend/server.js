const express = require('express');
const cors = require('cors');
const authRoutes = require('./routes/auth');
const dashboardRoutes = require('./routes/dashboard');
const challengesRoutes = require('./routes/challenges');
const leaderboardRoutes = require('./routes/leaderboard');
const postsRoutes = require('./routes/posts');

const app = express();
const port = process.env.PORT || 5001;

app.use(cors());
app.use(express.json());

app.use('/api/auth', authRoutes);
app.use('/api/dashboard', dashboardRoutes);
app.use('/api/challenges', challengesRoutes);
app.use('/api/leaderboard', leaderboardRoutes);
app.use('/api/posts', postsRoutes);

app.listen(port, () => {
  console.log(`Server is running on port: ${port}`);
});
