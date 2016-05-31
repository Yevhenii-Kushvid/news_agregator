# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

category = Category.create(name: "News")

DataSource.create(name: "Dayly Express",  link: "http://feeds.feedburner.com/daily-express-news-showbiz?format=xml", category:category)
DataSource.create(name: "BBC",            link: "http://feeds.bbci.co.uk/news/rss.xml", category:category)
DataSource.create(name: "LifeHaker",      link: "http://feeds.gawker.com/lifehacker/full", category:category)
DataSource.create(name: "TheGuardian",    link: "http://www.theguardian.com/world/rss", category:category)
