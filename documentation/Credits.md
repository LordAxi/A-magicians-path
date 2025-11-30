<script>
async function loadCredits() {
  const response = await fetch(
    "https://raw.githubusercontent.com/LordAxi/A-magicians-path/refs/heads/main/credits.json"
  );
  const data = await response.json();

  const p = document.getElementById("p");

  // Falls das JSON ein Array ist: Jede Zeile einzeln ausgeben
  if (Array.isArray(data)) {
    p.innerHTML = data.join("<br>");
  } else {
    p.innerHTML = JSON.stringify(data, null, 2).replace(/\n/g, "<br>");
  }
}

loadCredits();
</script>

# Credits

<p class="credits" id="p"></p>
