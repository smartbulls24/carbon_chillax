const express = require('express');
const router = express.Router();
const challengesController = require('../controllers/challengesController');

router.post('/:id/join', challengesController.joinChallenge);
router.post('/:id/complete', challengesController.completeChallenge);

module.exports = router;
