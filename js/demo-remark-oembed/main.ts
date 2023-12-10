import fs from "fs";
import { remark } from "remark";
import oembed from "@agentofuser/remark-oembed";

remark()
  .use(oembed)
  .process(fs.readFileSync("demo.md"), function (err, file) {
    if (err) throw err;
    console.log(String(file));
  });
