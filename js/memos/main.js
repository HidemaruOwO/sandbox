let isSidebarSwapped = false;

function swapSidebar() {
  if (isSidebarSwapped) {
    return;
  }
  console.log("Loading swap sidebar script...");
  const sidebarSections = [
    { id: "header-home", text: "🏠 Home" },
    { id: "header-daily-review", text: "📅 Daily Review" },
    { id: "header-resources", text: "🗂️ Resources" },
    { id: "header-explore", text: "🏂 Explore" },
    { id: "header-archived", text: "📦 Archived" },
    { id: "header-setting", text: "⚙️ Setting" },
  ];
  let isSuccess = [];
  sidebarSections.forEach((sidebarSection) => {
    const element = document.getElementById(sidebarSection.id);

    if (element) {
      while (element.firstChild) {
        element.removeChild(element.firstChild);
      }

      const textNode = document.createTextNode(sidebarSection.text);
      element.appendChild(textNode);

      element.style.fontWeight = "600";
      console.log(`Element with id ${sidebarSection.id} updated`);
      isSuccess.push(true);
    } else {
      console.error(`Element with id ${sidebarSection.id} not found`);
      isSuccess.push(false);
    }
  });
  isSuccess.includes(false)
    ? (isSidebarSwapped = false)
    : (isSidebarSwapped = true);
}

setTimeout(() => swapSidebar(), 100);
setTimeout(() => swapSidebar(), 400);
setTimeout(() => swapSidebar(), 500);
setInterval(() => {
  swapSidebar();
  if (isSidebarSwapped) {
    clearInterval();
  }
}, 500);
