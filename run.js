// vim: sw=2 ts=2 expandtab smartindent
const fullproglen = 147*2;

(async () => {
  const fs = require("fs");
  const { StringDecoder } = require('string_decoder');

  const bytes = fs.readFileSync(process.argv[2]);
  const { instance } = await WebAssembly.instantiate(bytes);
  console.log("successfully compiled " + process.argv[2]);

  const ptr = 0;// instance.exports.heap_base;
  instance.exports.exec(ptr);
  console.log("successfully executed " + process.argv[2] + ":exec(" + ptr + ")");

  const mem = instance.exports.memory.buffer;
  const out = new Uint8Array(mem, ptr, fullproglen);
  console.log(
    [...out].map(x => {
      const s = new Number(x).toString(16);
      return '\\'+((s.length == 1) ? '0'+s : s);
    }).join(''));
  fs.writeFileSync("baby.wasm", out);
  console.log("received and wrote out baby.wasm");

  const baby = (await WebAssembly.instantiate(out)).instance;
  console.log("successfully compiled baby.wasm");
  baby.exports.exec(ptr);
  console.log("successfully executed baby.wasm:exec(" + ptr + ")");
  const babymem = baby.exports.memory.buffer;
  {
    const out = new Uint8Array(babymem, ptr, fullproglen);
    console.log(
      [...out].map(x => {
        const s = new Number(x).toString(16);
        return '\\'+((s.length == 1) ? '0'+s : s);
      }).join(''));
  }

  console.log("build was successful (?)");

  // console.log(new Uint8Array(babymem, ptr)[1]);
  // const strlen = new Uint8Array(babymem, ptr).indexOf(0);
  // console.log(new StringDecoder().write(
  //   new Uint8Array(babymem, ptr, strlen)));
})();
