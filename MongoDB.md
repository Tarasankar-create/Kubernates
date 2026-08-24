# MongoDB Commands Reference

A quick reference of common MongoDB shell commands with sample outputs.

## Database & Collection

\`\`\`javascript
show dbs
use mydb                          // switch/create db
db.dropDatabase()
show collections
db.createCollection("users")
db.users.drop()
\`\`\`

## Insert

\`\`\`javascript
db.users.insertOne({name: "Tom", age: 25})
// { acknowledged: true, insertedId: ObjectId("66d1f2...") }

db.users.insertMany([{name: "A"}, {name: "B"}])
// { acknowledged: true, insertedIds: { '0': ObjectId('...'), '1': ObjectId('...') } }
\`\`\`

## Find (Read)

\`\`\`javascript
db.users.find()
/*
[
  { _id: ObjectId("66d1f2..."), name: "Tom", age: 25 },
  { _id: ObjectId("66d1f3..."), name: "A" },
  { _id: ObjectId("66d1f4..."), name: "B" }
]
*/

db.users.find().pretty()
db.users.findOne({name: "Tom"})
// { _id: ObjectId("66d1f2..."), name: "Tom", age: 25 }

db.users.find({age: {$gt: 20}})
db.users.find({age: {$gte: 20, $lte: 30}})
db.users.find({name: {$in: ["Tom", "Jerry"]}})
db.users.find({}, {name: 1, _id: 0})   // projection
db.users.find().sort({age: -1})
db.users.find().limit(5)
db.users.find().skip(10)

db.users.countDocuments({age: {$gt: 18}})
// 1
\`\`\`

## Update

\`\`\`javascript
db.users.updateOne({name: "Tom"}, {$set: {age: 26}})
// { acknowledged: true, matchedCount: 1, modifiedCount: 1 }

db.users.updateMany({age: {$lt: 18}}, {$set: {minor: true}})
// { acknowledged: true, matchedCount: 0, modifiedCount: 0 }

db.users.replaceOne({name: "Tom"}, {name: "Tom", age: 30})
db.users.updateOne({name: "Tom"}, {$inc: {age: 1}})
db.users.updateOne({name: "Tom"}, {$unset: {age: ""}})
db.users.updateOne({name: "Tom"}, {$push: {tags: "vip"}})
\`\`\`

## Delete

\`\`\`javascript
db.users.deleteOne({name: "Tom"})
// { acknowledged: true, deletedCount: 1 }

db.users.deleteMany({age: {$lt: 18}})
\`\`\`

## Indexes

\`\`\`javascript
db.users.createIndex({name: 1})
// "name_1"

db.users.getIndexes()
/*
[
  { v: 2, key: { _id: 1 }, name: "_id_" },
  { v: 2, key: { name: 1 }, name: "name_1" }
]
*/

db.users.dropIndex("name_1")
\`\`\`

## Aggregation

\`\`\`javascript
db.users.aggregate([
  {$match: {age: {$gt: 18}}},
  {$group: {_id: "$city", total: {$sum: 1}}},
  {$sort: {total: -1}}
])
/*
[
  { _id: "Delhi", total: 3 },
  { _id: "Mumbai", total: 2 }
]
*/
\`\`\`

## Admin / Utility

\`\`\`javascript
db.stats()
db.users.stats()
db.users.find().explain("executionStats")
\`\`\`

---

**Note:** `ObjectId` values shown in sample outputs are auto-generated and will differ every time these commands are run.
