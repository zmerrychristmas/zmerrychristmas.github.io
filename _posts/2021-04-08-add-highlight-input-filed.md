---
title: Add highlight input filed
categories:
- Fullstack
- Stylesheets
tags:
- input
- bootstrap
- blue-highline
---

```css
textarea:focus,
input[type="text"]:focus,
input[type="password"]:focus,
input[type="datetime"]:focus,
input[type="datetime-local"]:focus,
input[type="date"]:focus,
input[type="month"]:focus,
input[type="time"]:focus,
input[type="week"]:focus,
input[type="number"]:focus,
input[type="email"]:focus,
input[type="url"]:focus,
input[type="search"]:focus,
input[type="tel"]:focus,
input[type="color"]:focus,
.uneditable-input:focus {
  border-color: rgba(44, 130, 201, 1);
  box-shadow: 0 1px 1px rgba(0, 0, 0, 0.075) inset, 0 0 8px rgba(44, 130, 201, 1);
  outline: 0 none;
}
```
