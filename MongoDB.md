## MongoDB Commands with Output
```bash
show dbs
# admin  0.000GB
# config 0.000GB
# local  0.000GB

use mydb
# switched to db mydb

db.dropDatabase()
# { ok: 1, dropped: 'mydb' }

show collections
# users

db.createCollection("users")
# { ok: 1 }

db.users.drop()
# true

db.users.insertOne({name: "Tom", age: 25, city: "Delhi"})
# { acknowledged: true, insertedId: ObjectId("66d1f2a1b3c4d5e6f7890123") }

db.users.insertMany([{name: "A", age: 15, city: "Mumbai"}, {name: "B", age: 22, city: "Delhi"}])
# {
#   acknowledged: true,
#   insertedIds: {
#     '0': ObjectId("66d1f2a1b3c4d5e6f7890124"),
#     '1': ObjectId("66d1f2a1b3c4d5e6f7890125")
#   }
# }

db.users.find()
# [
#   { _id: ObjectId("66d1f2a1..."), name: "Tom", age: 25, city: "Delhi" },
#   { _id: ObjectId("66d1f2a1..."), name: "A", age: 15, city: "Mumbai" },
#   { _id: ObjectId("66d1f2a1..."), name: "B", age: 22, city: "Delhi" }
# ]

db.users.findOne({name: "Tom"})
# { _id: ObjectId("66d1f2a1..."), name: "Tom", age: 25, city: "Delhi" }

db.users.find({age: {$gt: 20}})
# [
#   { _id: ObjectId("..."), name: "Tom", age: 25, city: "Delhi" },
#   { _id: ObjectId("..."), name: "B", age: 22, city: "Delhi" }
# ]

db.users.find({age: {$gte: 20, $lte: 30}})
# same as above, both within range

db.users.find({name: {$in: ["Tom", "Jerry"]}})
# [ { _id: ObjectId("..."), name: "Tom", age: 25, city: "Delhi" } ]

db.users.find({}, {name: 1, _id: 0})
# [ { name: "Tom" }, { name: "A" }, { name: "B" } ]

db.users.find().sort({age: -1})
# sorted descending by age: Tom(25), B(22), A(15)

db.users.find().limit(2)
# returns first 2 documents only

db.users.find().skip(1)
# skips first document, returns the rest

db.users.countDocuments({age: {$gt: 18}})
# 2

db.users.updateOne({name: "Tom"}, {$set: {age: 26}})
# { acknowledged: true, matchedCount: 1, modifiedCount: 1 }

db.users.updateMany({age: {$lt: 18}}, {$set: {minor: true}})
# { acknowledged: true, matchedCount: 1, modifiedCount: 1 }

db.users.replaceOne({name: "Tom"}, {name: "Tom", age: 30})
# { acknowledged: true, matchedCount: 1, modifiedCount: 1 }

db.users.updateOne({name: "Tom"}, {$inc: {age: 1}})
# { acknowledged: true, matchedCount: 1, modifiedCount: 1 }

db.users.updateOne({name: "Tom"}, {$unset: {age: ""}})
# { acknowledged: true, matchedCount: 1, modifiedCount: 1 }

db.users.updateOne({name: "Tom"}, {$push: {tags: "vip"}})
# { acknowledged: true, matchedCount: 1, modifiedCount: 1 }

db.users.deleteOne({name: "Tom"})
# { acknowledged: true, deletedCount: 1 }

db.users.deleteMany({age: {$lt: 18}})
# { acknowledged: true, deletedCount: 1 }

db.users.createIndex({name: 1})
# "name_1"

db.users.getIndexes()
# [
#   { v: 2, key: { _id: 1 }, name: "_id_" },
#   { v: 2, key: { name: 1 }, name: "name_1" }
# ]

db.users.dropIndex("name_1")
# { nIndexesWas: 2, ok: 1 }

db.users.aggregate([
  {$match: {age: {$gt: 18}}},
  {$group: {_id: "$city", total: {$sum: 1}}},
  {$sort: {total: -1}}
])
# [
#   { _id: "Delhi", total: 2 },
#   { _id: "Mumbai", total: 1 }
# ]

db.stats()
# {
#   db: 'mydb',
#   collections: 1,
#   objects: 3,
#   avgObjSize: 64,
#   dataSize: 192,
#   ok: 1
# }

db.users.stats()
# { ns: 'mydb.users', count: 3, size: 192, avgObjSize: 64, ... }

db.users.find().explain("executionStats")
# { queryPlanner: {...}, executionStats: { nReturned: 3, executionTimeMillis: 0, ... } }
