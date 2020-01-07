#!/usr/bin/env node

const readline = require('readline');

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

const lines = [];

rl.on('line', (input) => lines.push(input));

rl.on('close', processLines);

function processLines() {

  function extractDate(str) {
    return str.substring(0, 10);
  }

  function extractTime(str) {
    return str.substring(11, 16)
  }

  const days = [];

  let dayObj = {
    date: extractDate(lines[0]),
    times: []
  };

  for (let line of lines) {
    let currDate = extractDate(line);

    if (dayObj.date !== currDate) {
      days.push(dayObj);
      dayObj = {
        date: currDate,
        times: []
      };
    }

    dayObj.times.push(extractTime(line));
  }

  // we didn't push the last day before
  days.push(dayObj);

  for (let day of days) {

    let timeString = '';

    const times = day.times;

    for (let i = 0; i < times.length; i++) {

      const time = times[i];

      if (i === 0) {
        timeString += time;

      } else if (i % 2 === 0) {
        timeString += ',' + time;

      } else if (i % 2 === 1) {
        timeString += '-' + time;

      }
    }

    day.timeString = timeString;
  }

  for (let day of days) {
    const time = processTime(day.timeString);

    day.timeWorked = time;
  }

  let longestLength = 0;

  for (let day of days) {
    longestLength = Math.max(day.timeString.length, longestLength);
  }

  for (let day of days) {
    console.log(day.date + ' ' + day.timeString + '    ' + day.timeWorked.padStart(5 + longestLength - day.timeString.length));
  }

}

function processTime(fullTime) {

  const sectionedTimes = fullTime.split(',');

  const splitSectionedTimes = sectionedTimes
                                .map(t => t.split('-'))
                                .map(t => t.length === 2 ?
                                      ({ 
                                        "start": t[0].trim(),
                                        "end": t[1].trim()
                                      }) : null
                                );

  let total = 0;

  for (let splitSectionTime of splitSectionedTimes) {
    if (splitSectionTime !== null) {
      const start = splitSectionTime.start;
      const end = splitSectionTime.end;

      const startH = getHourComponent(start) + (getMinuteComponent(start) / 60);
      const endH = getHourComponent(end) + (getMinuteComponent(end) / 60);

      total += endH - startH;
    }
  }

  let totalH = total - (total % 1);
  let totalM = (total - totalH) * 60;

  return totalH.toString().padStart(2, '0') + ":" + Math.round(totalM).toString().padStart(2, '0');

  function getHourComponent(time) {
    return parseInt(time.split(":")[0]);
  }

  function getMinuteComponent(time) {
    return parseInt(time.split(":")[1]);
  }

}
