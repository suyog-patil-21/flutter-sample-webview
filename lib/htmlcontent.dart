String html = """
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Docuemnt Website</title>
  </head>
  <body>
    <h3 class="titleapp" id="titleID">Title of the page</h3>
    <input id="normainput" type="text" placeholder="Name" />
    <button id="btnid" onclick="submitBtn()">Submit</button>
    <p id="answer"></p>
    <script>
      function submitBtn() {
        console.log("button was pressed");
        const inputEl = document.getElementById("normainput");
        document.getElementById("answer").textContent = inputEl.value;
      }
    </script>
  </body>
</html>
""";
