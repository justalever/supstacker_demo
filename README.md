![Let's Build: A Supplement Stack Sharing App with Ruby on Rails](https://f001.backblazeb2.com/file/webcrunch/supstacker-cover.jpg)

# Let's Build: A Supplement Stack Sharing App with Ruby on Rails

Welcome to my latest Let’s build series.

Over the course of time I’ve added a number of these builds which have seemed to resonate with a lot of my audience.

I find these both useful from first principles product ideas but also nice way to practice for myself to see how quickly I can build an MVP of product ideas I have. Luckily with Rails, this can be done in little time

## Useful links

This guide is both in written and video format. Find both here:

- 🔗 Source code: https://github.com/justalever/supstacker_demo
- 📕 Written version: https://web-crunch.com/posts/supplement-stack-sharing-app-ruby-on-rails/
- 📺 Playlist: https://youtube.com/playlist?list=PL01nNIgQ4uxOhHYZd6THGIFVBALJZCcpM&si=kbdUW1JbM551tC-i

## Supstacker data modeling

- `User` - The model responsible for a given entity who might add and share supplment stacks.
- `Stack` - A collection of products a user can share.
- `Product` - Get's shared inside a Stack. Has richer data like price, description, title, etc.
- `Brand` - The brand of the supplement. One brand per supplement.
