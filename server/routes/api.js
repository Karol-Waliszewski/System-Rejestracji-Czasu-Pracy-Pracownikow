const express = require('express');
const router = express.Router();

/*
 * GET status:
 * 200 - OK
 * 404 - Not found - SQL Error
 *
 * POST status:
 * 201 - Created
 * 400 - Empty JSON - bad request
 * 409 - Conflict - SQL Error - Wrong json
 *
 *  *406 - ONLY IN ENTRIES TABLE - if worker tries to get in or out 2 times in a row
 *
 * DELETE status:
 * 200 - OK
 * 409 - Conflict - SQL Error - Wrong json
 *
 * PUT status:
 * 200 - OK
 * 400 - Empty JSON - bad request
 * 409 - Conflict - SQL Error - Wrong json
 *
 */

router.use('/workers', require('./workers') );
router.use('/jobs', require('./jobs') );
router.use('/depts', require('./depts') );
router.use('/entries', require('./entries') );
router.use('/payments', require('./payments') );

module.exports = router;
