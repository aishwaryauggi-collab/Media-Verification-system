<<<<<<< HEAD
async function fetchReports() {
    try {
        const response = await fetch("get_reports.php");
        const reports = await response.json();

        renderReports(reports);
    } catch (error) {
        console.error("Error fetching reports:", error);
    }
}

function renderReports(data) {
    const grid = document.getElementById("newsGrid");

    grid.innerHTML = "";

    data.forEach(report => {
        const card = document.createElement("div");

        card.className = "card";

        let score = report.combined_score || report.trust_rating;
        let status = report.status_label || "Unknown";

        card.innerHTML = `
            <h3>${report.headline}</h3>

            <p><strong>Publisher:</strong> ${report.publisher_name}</p>

            <p><strong>Trust Rating:</strong> ${report.trust_rating}</p>

            <p><strong>Shares:</strong> ${report.shares_count}</p>

            <p><strong>Verification Score:</strong> ${score}</p>

            <span class="status ${status}">
                ${status}
            </span>
        `;

        grid.appendChild(card);
    });
}

function filterReports() {
    const query =
        document.getElementById("searchInput")
        .value
        .toLowerCase();

    const cards =
        document.querySelectorAll(".card");

    cards.forEach(card => {
        const title =
            card.querySelector("h3")
            .innerText
            .toLowerCase();

        card.style.display =
            title.includes(query)
            ? "block"
            : "none";
    });
}

=======
async function fetchReports() {
    try {
        const response = await fetch("get_reports.php");
        const reports = await response.json();

        renderReports(reports);
    } catch (error) {
        console.error("Error fetching reports:", error);
    }
}

function renderReports(data) {
    const grid = document.getElementById("newsGrid");

    grid.innerHTML = "";

    data.forEach(report => {
        const card = document.createElement("div");

        card.className = "card";

        let score = report.combined_score || report.trust_rating;
        let status = report.status_label || "Unknown";

        card.innerHTML = `
            <h3>${report.headline}</h3>

            <p><strong>Publisher:</strong> ${report.publisher_name}</p>

            <p><strong>Trust Rating:</strong> ${report.trust_rating}</p>

            <p><strong>Shares:</strong> ${report.shares_count}</p>

            <p><strong>Verification Score:</strong> ${score}</p>

            <span class="status ${status}">
                ${status}
            </span>
        `;

        grid.appendChild(card);
    });
}

function filterReports() {
    const query =
        document.getElementById("searchInput")
        .value
        .toLowerCase();

    const cards =
        document.querySelectorAll(".card");

    cards.forEach(card => {
        const title =
            card.querySelector("h3")
            .innerText
            .toLowerCase();

        card.style.display =
            title.includes(query)
            ? "block"
            : "none";
    });
}

>>>>>>> b7234eb0a4607a1b3be541d729ec896dce1dc0f3
fetchReports();