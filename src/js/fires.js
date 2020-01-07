const xmlParser = new  DOMParser()
const RSS_FEED = "http://www.rfs.nsw.gov.au/feeds/major-Fire-Updates.xml"
const AMAZON_HA = 906000;

// This can't be an arrow function, it will bind 'this' to window
XPathResult.prototype.map = function(f) {
    const result = [];
    let i = 0;

    let item = this.iterateNext();

    while(item) {
        result.push(f(item, i++, this));
        item = this.iterateNext();
    }

    return result;
}

// This works because all the elements children are name - val pairs
const rssItemToObject = rssItem => {
    const children = [...rssItem.children];
    const entries = children.map(({ nodeName, innerHTML }) => [nodeName, innerHTML]);

    return Object.fromEntries(entries);
}

const addChildToTemplate = template => (selector, content) => {
    const element = template.querySelector(selector);

    if (element) {
        (typeof content === "object")
            ? element.appendChild(content)
            : element.innerHTML = content;
    } else {
        console.warn("No element found in template");
    }
}

const fetchData = async () => {
    const response = await fetch(`http://cors-anywhere.herokuapp.com/${RSS_FEED}`)
    const xmlString = await response.text();
    const headers = response.headers;
    return xmlParser.parseFromString(xmlString, "text/xml");
}

const getTitleLink = (template, rssObj) => {
    const title = template.querySelector(".incident-link");
    title.innerHTML = rssObj.title;
    title.href = rssObj.link;

    return title;
}

const rssObjToHtmlNode = originalTemplateElement => rssObj => {
    const template = originalTemplateElement.cloneNode(true);
    const addChild = addChildToTemplate(template);

    getTitleLink(template, rssObj);
    addChild(".incident-description", rssObj.description);
    addChild(".incident-date", rssObj["a10:updated"]);

    return template;
}

const numRegex = /[0-9]+,[0-9]+/

const grabHA = ({ description }) => description.match(numRegex);


const main = async () => {
    const incidentTemplate = document.getElementById("incident-template").content;
    const list = document.getElementById("incident-list");
    const total = document.getElementById("total");

    const rssDoc = await fetchData();
    const results = rssDoc.evaluate("//item", rssDoc, null, XPathResult.ANY_TYPE, null);

    const addToList = node => {
        list.appendChild(node);
        return node;
    }

    const items = results.map(rssItemToObject)
    const htmlNodes = items.map(rssObjToHtmlNode(incidentTemplate))
    htmlNodes.forEach(node => list.appendChild(node));

    const incidentCount = items.length;

    const totalArea = items
        .flatMap(grabHA)
        .filter(x => !!x)
        .map(x => x.replace(",", ""))
        .map(x => parseInt(x, 10))
        .reduce((a, b) => a + b, 0);

    console.log(totalArea);
    total.innerHTML = `
        <p>There is an estimated ${totalArea.toLocaleString()} HA burning right now in the ${incidentCount} major fires being reported.</p>
        <p>That is ~${(totalArea / AMAZON_HA).toLocaleString()}x the size of the 2019 Amazon Rainforest Fires burning <b>now.</b></p>
    `;

}

main();

