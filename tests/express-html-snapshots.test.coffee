expect = require 'expect.js'
server = require '../samples/angularjs/server'
Browser = require 'zombie'

describe 'test express html snapshots', () ->

    before (done) ->
        this.browser = new Browser()
        this.browser.runScripts = false
        this.browser.on 'error', (err) =>
            done err
        server.start done

    after (done) ->
        this.browser.close()
        server.close done

    it 'should render the website for google search bot', (done) ->
        url = 'http://localhost:3000/?_escaped_fragment_=%2Fhome&q=openify.it'
        this.browser.visit url, (err, browser) ->
            expect(err).not.to.be.ok()
            expect(browser.success).to.be.ok()
            expect(browser.statusCode).to.be.eql(200)
            expect(browser.text('#content')).to.be.eql('Generated on client-side')
            done()

    it 'should render website for Google bot without _escaped_fragment_', (done) ->
        userAgent = 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)'
        url = 'http://localhost:3000/'
        this.browser.visit url, {userAgent: userAgent}, (err, browser) ->
            expect(err).not.to.be.ok()
            expect(browser.success).to.be.ok()
            expect(browser.statusCode).to.be.eql(200)
            expect(browser.text('#content')).to.be.eql('Generated on client-side')
            done()

    it 'should render website for Bing bot without _escaped_fragment_', (done) ->
        userAgent = 'Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)'
        url = 'http://localhost:3000/'
        this.browser.visit url, {userAgent: userAgent}, (err, browser) ->
            expect(err).not.to.be.ok()
            expect(browser.success).to.be.ok()
            expect(browser.statusCode).to.be.eql(200)
            expect(browser.text('#content')).to.be.eql('Generated on client-side')
            done()

    it 'should render website for Yahoo! bot without _escaped_fragment_', (done) ->
        userAgent = 'Mozilla/5.0 (compatible; Yahoo! Slurp; http://help.yahoo.com/help/us/ysearch/slurp)'
        url = 'http://localhost:3000/'
        this.browser.visit url, {userAgent: userAgent}, (err, browser) ->
            expect(err).not.to.be.ok()
            expect(browser.success).to.be.ok()
            expect(browser.statusCode).to.be.eql(200)
            expect(browser.text('#content')).to.be.eql('Generated on client-side')
            done()
