'use strict';
const AWS = require('aws-sdk');

AWS.config.update({ region: 'us-east-1' });

exports.handler = async (event) => {

    const docClient = new AWS.DynamoDB.DocumentClient();

    const params = {
        TableName: 'places',
    };

    try {
        console.log('Querying all places.');
        const data = await docClient.scan(params).promise();
        console.log(`Count: ${data.Count}, Scanned Count: ${data.ScannedCount}`);
        return data.Items;
    } catch (error) {
        console.error(error.stack);
        return error;
    }
};