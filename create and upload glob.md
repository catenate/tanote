[[urbit app]] [[tanote/tanote]]

## create files for glob

We'll now create the files for the glob. We'll use a very simple static HTML page that just displays "Hello World!" and an image. Typically we'd have a more complex JS web app that talked to apps on our ship through the server API, but for the sake of simplicity we'll forgo that. Let's hop back in the Unix terminal.

```bash
cd git/tanote
mkdir tanote-glob
cd tanote-glob
mkdir img
curl https://media.urbit.org/docs/userspace/dist/pot.svg --output img/pot.svg
```

We've grabbed an image to use in our "Hello world!" page. The next thing we need to add is an `index.html` file in the root of the folder. The `index.html` file is mandatory; it's what will be loaded when the app's tile is clicked.

```html
<!DOCTYPE html>
<html>
    <head>
        <title>tanote</title>
        <style>
            body {
                text-align: center;
            }
        </style>
    </head>
    <body>
        <h1>a community knowledge manager</h1>
        <img src="img/pot.svg" alt="pot" width="219" height="196" />
    </body>
</html>
```

## upload to glob

We can now create a glob from the directory. To do so, navigate to [docket/upload](http://localhost:80/docket/upload) in the browser.  This will bring up the `%docket` app's Globulator tool.

1.  Simply select the `tanote` desk from the drop-down, click `Choose file` and select the `tanote-glob` folder in the file browser, then hit `glob!`.
2.  Now if we return to our ship's homescreen, we should see the tile looks as we specified in the docket file: `http://localhost:80`
3.  And if we click on the tile, it'll load the `index.html` in our glob.
4.  Our app is working!

