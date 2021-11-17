# Generate html strings in haskell.

[blog.hs](blog.hs) example I am creating a server-side rendered personal blog

preview

![blog.hs rendered to html](screen_blog.png)

#### Running the hotreloaded renderer

```bash
npm start
```
Open on http://localhost:8080

#### Compiling

```bash
runghc blog.hs -> blog.html
```

#### Requirements

Glasgow Haskell Compiler, Version 8.10.7

For helper scripts

Node v16.11.0

Npm 8.0.0

Dependencies

    node-watch ^0.7.2

    ws ^8.2.3