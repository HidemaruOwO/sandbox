const TOKEN = "";

async function fetchGuild() {
  const res = await fetch(
    "https://discord.com/api/v10/guilds/1152588900947206176",
    {
      headers: {
        Authorization: TOKEN,
      },
    },
  );

  return res.json();
}

const fetchUser = async () => {
  const res = await fetch(
    "https://discord.com/api/v10/users/830789490481954856",
    {
      headers: {
        Authorization: TOKEN,
      },
    },
  );
  return res.json();
};

async function fetchData() {
  try {
    const userPromise = fetchUser();
    const guildPromise = fetchGuild();

    const userData = await userPromise;
    const guildData = await guildPromise;

    console.log("User Data:", userData);
    console.log("Guild Data:", guildData);
  } catch (error) {
    console.error("Error:", error);
  }
}

fetchData();
