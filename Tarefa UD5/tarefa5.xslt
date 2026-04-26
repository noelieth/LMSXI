<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <!-- Salida en formato HTML -->
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>

    <xsl:template match="/">

        <html>
            <head>
                <title>Resultados XPath - Equipos</title>
                <style>
                    body {
                        font-family: Arial;
                        margin: 20px;
                    }

                    h1 {
                        color: #2c3e50;
                    }

                    h2 {
                        margin-top: 30px;
                        color: #34495e;
                    }

                    ul {
                        margin-bottom: 20px;
                    }

                    li {
                        margin: 5px 0;
                    }

                    .resultado {
                        background: #f4f4f4;
                        padding: 10px;
                        border: 1px solid #ccc;
                    }
                </style>
            </head>

            <body>

                <h1>Resultados de Expresiones XPath</h1>

                <!-- a -->
                <h2>a) Máquinas con nomes que comezan por "PC".</h2>
                <ul>
                    <xsl:for-each select="equipos/maquina[starts-with(@nome,'PC')]">
                        <li>
                            <xsl:value-of select="@nome"/>
                        </li>
                    </xsl:for-each>
                </ul>

                <!-- b -->
                <h2>b) O nome das máquinas con máis dun disco duro.</h2>
                <ul>
                    <xsl:for-each select="equipos/maquina[count(hardware/disco) &gt; 1]">
                        <li>
                            <xsl:value-of select="@nome"/>
                        </li>
                    </xsl:for-each>
                </ul>

                <!-- c -->
                <h2>c) A suma das capacidades dos discos duros de tipo "SCSI".</h2>
                <div class="resultado">
                    <xsl:value-of select="sum(equipos/maquina/hardware/disco[@tecnoloxia='SCSI']/@capacidade)"/>
                </div>

                <!-- d -->
                <h2>d) Os nomes das máquinas cuxa capacidade de memoria se coñece, pero non a tecnoloxía desa memoria.</h2>
                <ul>
                    <xsl:for-each select="equipos/maquina[hardware/memoria and not(hardware/memoria/@tecnoloxia)]">
                        <li>
                            <xsl:value-of select="@nome"/>
                        </li>
                    </xsl:for-each>
                </ul>

                <!-- e -->
                <h2>e) Máquinas con sistemas operativos Windows e unidades de DVD.</h2>
                <ul>
                    <xsl:for-each select="equipos/maquina[
                        contains(config/OS,'Windows')
                        and
                        (hardware/gravadora[@tipo='DVD'] or hardware/lectora[@tipo='DVD'])
                    ]">
                        <li>
                            <xsl:value-of select="@nome"/>
                        </li>
                    </xsl:for-each>
                </ul>

                <!-- f -->
                <h2>f) O nome da máquina e o sistema operativo para as máquinas con máis dun disco duro.</h2>
                <ul>
                    <xsl:for-each select="equipos/maquina[count(hardware/disco) &gt; 1]">
                        <li>
                            <strong>Máquina:</strong>
                            <xsl:value-of select="@nome"/>
                            —
                            <strong>SO:</strong>
                            <xsl:value-of select="config/OS"/>
                        </li>
                    </xsl:for-each>
                </ul>

                <!-- g -->
                <h2>g) A configuración daquelas máquinas que teñen un enderezo IP listado, pero non a porta de enlace.</h2>
                <ul>
                    <xsl:for-each select="equipos/maquina[config/IP and not(config/gateway)]">
                        <li>
                            <strong>
                                <xsl:value-of select="@nome"/>
                            </strong>
                            :
                            <xsl:value-of select="config/OS"/>
                            -
                            <xsl:value-of select="config/IP"/>
                        </li>
                    </xsl:for-each>
                </ul>

                <!-- h -->
                <h2>h) Os enderezos IP dentro da rede 192.168.10.0/24.</h2>
                <ul>
                    <xsl:for-each select="equipos/maquina/config/IP[starts-with(.,'192.168.10.')]">
                        <li>
                            <xsl:value-of select="."/>
                        </li>
                    </xsl:for-each>
                </ul>

                <!-- i -->
                <h2>i) Os nomes das máquinas cun procesador multinúcleo e 2 GB ou menos de memoria.</h2>
                <ul>
                    <xsl:for-each select="equipos/maquina[
                        hardware/procesador[@num_nucleos &gt; 1]
                        and
                        hardware/memoria &lt;= 2
                    ]">
                        <li>
                            <xsl:value-of select="@nome"/>
                        </li>
                    </xsl:for-each>
                </ul>

                <!-- j -->
                <h2>j) Máquinas que teñen un disco duro (un ou máis) cunha capacidade total inferior a 80 GB.</h2>
                <ul>
                    <xsl:for-each select="equipos/maquina[
                        sum(hardware/disco/@capacidade) &lt; 80
                    ]">
                        <li>
                            <xsl:value-of select="@nome"/>
                        </li>
                    </xsl:for-each>
                </ul>

            </body>
        </html>

    </xsl:template>

</xsl:stylesheet>