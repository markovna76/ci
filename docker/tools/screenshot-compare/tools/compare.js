#!/usr/bin/env node

process.on('uncaughtException', (error) => {
    console.error(error);
    process.exit(1);
});
process.on('unhandledRejection', (reason, p) => {
    console.error(reason, p);
    process.exit(1);
});

const puppeteer = require('puppeteer');
const ScreenshotTester = require('puppeteer-screenshot-tester')

// console.log(process.argv);

if (!process.argv[2]) {
    console.error('ERROR: no url arg\n');
    console.info('for example:\n');
    console.log('  docker run --shm-size 1G --rm -v /tmp:/screenshots \\');
    console.log('  ofte/screencompare:latest screencompare \'https://www.google.com\'\n');
    process.exit(1);
}
var url = process.argv[2];
var now = new Date();
var dateStr = now.toISOString();
var width = 800;
var height = 600;
if (typeof process.argv[3] === 'string') {
    var [width, height] = process.argv[3].split('x').map(v => parseInt(v, 10));
}
var projname = 'compare';
if (typeof process.argv[4] === 'string') {
    projname = process.argv[4];
}
var isMobile = false;
let filename = `${projname}${width}_${height}.png`;
(async () => {
    const browser = await puppeteer.launch({
        args: [
            '--no-sandbox',
            '--disable-setuid-sandbox'
        ]
    });
    const page = await browser.newPage();
    const tester = await ScreenshotTester(0.8, false, false, [], {
        transparency: 0.5
    })
    await page.goto(url, {waitUntil: 'networkidle2'});
    await page.setViewport({
        width,
        height,
        isMobile
    });
    const result = await tester(page, 'test2', {
        path: `/screenshots/${filename}`,
        fullPage: true,
    })
    await page.close();
    await browser.close();

    console.log(
        JSON.stringify({
            date: dateStr,
            timestamp: Math.floor(now.getTime() / 1000),
            filename,
            width,
            height
        })
    );
})();
