<?xml version="1.0" encoding="utf-8"?>
<!--

   * A small transfor to put Waypoints downloaded from Cachetur.no
     directly into a route on my Garmin SmartDrive 50.

   * Assumptions and caveats;
     * Waypoints in the file exported from Cachetur.no is already in the
       correct order. This has been true for the samples I have tried so
       far, but I don't think there exists any guarantee for this.
     * After starting the Garmin unit with new routes it uses long time
       before the route is visible.
     * Only the cachename is included in the file produced here, but I guess
       most users will already have the needed caches on the Garminunit
       already, either by export from Gsak, or by placing the source-file
       used by this transform directly into the GPX-directory on the Garmin.

-->

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.topografix.com/GPX/1/1"
                xmlns:gpxx="http://www.garmin.com/xmlschemas/GpxExtensions/v3"
                xmlns:gpxtpx="http://www.garmin.com/xmlschemas/TrackPointExtension/v2"
                xmlns:trp="http://www.garmin.com/xmlschemas/TripExtensions/v1"
                xmlns:vs="http://www.garmin.com/xmlschemas/VehicleSourceExtensions/v1"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:ns1="http://www.topografix.com/GPX/1/0">
  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="/">
    <xsl:apply-templates select="/ns1:gpx" />
      </xsl:template>

  <xsl:template match="/ns1:gpx">
    <xsl:element name="gpx">
      <xsl:element name="metadata">
        <xsl:element name="link">
          <xsl:value-of select="ns1:author"/>
        </xsl:element>
        <xsl:element name="time">
          <xsl:value-of select="ns1:time"/>
        </xsl:element>
        <xsl:element name="extensions">
          <xsl:element name="vs:srcid">
            <!-- Unsure about this value. -->
            <xsl:text>359828952</xsl:text>
          </xsl:element>
        </xsl:element>
      </xsl:element>

      <xsl:element name="rte">
        <xsl:element name="name">
          <xsl:value-of select="substring(ns1:desc, 20)"/>
        </xsl:element>
        <xsl:element name="extensions">
          <xsl:element name="trp:trip">
            <xsl:element name="trp:TransportationMode">
              <xsl:text>Automotive</xsl:text>
            </xsl:element>
          </xsl:element>
        </xsl:element>

        <xsl:apply-templates select="ns1:wpt"/>
        
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <xsl:template match="ns1:wpt">
    <xsl:element name="rtept">
      <xsl:attribute name="lat">
        <xsl:value-of select="@lat"/>
      </xsl:attribute>
      <xsl:attribute name="lon">
        <xsl:value-of select="@lon"/>
      </xsl:attribute>
      <xsl:element name="name">
        <xsl:value-of select="ns1:desc"/>
      </xsl:element>
    </xsl:element>
  </xsl:template>
</xsl:stylesheet>
