/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20180427 (64-bit version)(RM)
 * Copyright (c) 2000 - 2018 Intel Corporation
 * 
 * Disassembling to non-symbolic legacy ASL operators
 *
 * Disassembly of SSDT-FAN.aml, Wed Feb 13 08:39:01 2019
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x000003C3 (963)
 *     Revision         0x02
 *     Checksum         0x2E
 *     OEM ID           "Nick"
 *     OEM Table ID     "AsusFan"
 *     OEM Revision     0x00000000 (0)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20161210 (538317328)
 */
DefinitionBlock ("", "SSDT", 2, "Nick", "AsusFan", 0x00000000)
{
    External (_SB_.ATKD.QMOD, MethodObj)    // 1 Arguments (from opcode)
    External (_SB_.PCI0.LPCB.EC0_.ECAV, MethodObj)    // 0 Arguments (from opcode)
    External (_SB_.PCI0.LPCB.EC0_.ECPU, FieldUnitObj)    // (from opcode)
    External (_SB_.PCI0.LPCB.EC0_.ST83, MethodObj)    // 1 Arguments (from opcode)
    External (_SB_.PCI0.LPCB.EC0_.TACH, MethodObj)    // 1 Arguments (from opcode)
    External (_SB_.QFAN, FieldUnitObj)    // (from opcode)

    Device (ANKD)
    {
        Name (_HID, "ANKD0000")  // _HID: Hardware ID
        Name (UCFC, One)
    }

    Device (SMCD)
    {
        Name (_HID, "FAN0000")  // _HID: Hardware ID
//        Name (TACH, Package (0x02)
//        {
//            "System FAN", 
//            "FAN0"
//        })
        Name (TEMP, Package (0x02)
        {
            "CPU Heatsink", 
            "TCPU"
        })
        Method (FAN0, 0, NotSerialized)
        {
            If (\_SB.PCI0.LPCB.EC0.ECAV ())
            {
                Store (\_SB.PCI0.LPCB.EC0.ST83 (Zero), Local0)
                If (LEqual (Local0, 0xFF))
                {
                    Return (Local0)
                }

                Store (\_SB.PCI0.LPCB.EC0.TACH (Zero), Local0)
            }
            Else
            {
                Store (Zero, Local0)
            }

            Return (Local0)
        }

        Method (TCPU, 0, NotSerialized)
        {
            If (\_SB.PCI0.LPCB.EC0.ECAV ())
            {
                Store (\_SB.PCI0.LPCB.EC0.ECPU, Local0)
                Store (0x3C, Local1)
                If (LLess (Local0, 0x80))
                {
                    Store (Local0, Local1)
                }
            }
            Else
            {
                Store (Zero, Local1)
            }

            Return (Local1)
        }

        Name (FTA1, Package (0x16)
        {
            0x20, 
            0x21, 
            0x22, 
            0x23, 
            0x24, 
            0x25, 
            0x26, 
            0x27, 
            0x28, 
            0x29, 
            0x2A, 
            0x2B, 
            0x2C, 
            0x2D, 
            0x2E, 
            0x2F, 
            0x30, 
            0x31, 
            0x32, 
            0x33, 
            0x34, 
            0xFF
        })
        Name (FTA2, Package (0x16)
        {
            Zero, 
            0x0A, 
            0x14, 
            0x1E, 
            0x28, 
            0x32, 
            0x3C, 
            0x46, 
            0x50, 
            0x5A, 
            0x64, 
            0x6E, 
            0x78, 
            0x82, 
            0x8C, 
            0xA0, 
            0xB9, 
            0xCD, 
            0xE1, 
            0xF5, 
            0xFA, 
            0xFF
        })
        Name (FCTU, 0x02)
        Name (FCTD, 0x05)
        Name (FHST, Buffer (0x16)
        {
            /* 0000 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            /* 0008 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            /* 0010 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00             
        })
        Name (FIDX, Zero)
        Name (FNUM, Zero)
        Name (FSUM, Zero)
        Name (FLST, 0xFF)
        Name (FCNT, Zero)
        Method (FCPU, 0, NotSerialized)
        {
            If (LEqual (\ANKD.UCFC, Zero))
            {
                Return (Zero)
            }

            If (LNot (\_SB.PCI0.LPCB.EC0.ECAV ()))
            {
                Return (Zero)
            }

            Store (\_SB.PCI0.LPCB.EC0.ECPU, Local5)
            If (LLess (Local5, 0x80))
            {
                Store (Local5, Local0)
            }
            Else
            {
                Store (0x3C, Local0)
            }

            Add (Local0, FSUM, Local1)
            Store (FIDX, Local2)
            Subtract (Local1, DerefOf (Index (FHST, Local2)), Local1)
            Store (Local0, Index (FHST, Local2))
            Store (Local1, FSUM)
            Increment (Local2)
            If (LGreaterEqual (Local2, SizeOf (FHST)))
            {
                Store (Zero, Local2)
            }

            Store (Local2, FIDX)
            Store (FNUM, Local2)
            If (LNotEqual (Local2, SizeOf (FHST)))
            {
                Increment (Local2)
                Store (Local2, FNUM)
            }

            Divide (Local1, Local2, , Local0)
            If (LGreater (Local0, 0xFF))
            {
                Store (0xFF, Local0)
            }

            Store (Match (FTA1, MGE, Local0, MTR, Zero, Zero), Local2)
            If (LGreater (Local2, FLST))
            {
                Subtract (Local2, FLST, Local1)
                Store (FCTU, Local4)
            }
            Else
            {
                Subtract (FLST, Local2, Local1)
                Store (FCTD, Local4)
            }

            If (LNot (Local1))
            {
                Store (Zero, FCNT)
            }
            Else
            {
                Store (FCNT, Local3)
                Increment (FCNT)
                Divide (Local4, Local1, , Local1)
                If (LGreaterEqual (Local3, Local1))
                {
                    Store (Local2, FLST)
                    Store (DerefOf (Index (FTA2, Local2)), Local5)
                    Store (Local5, \_SB.QFAN)
                    \_SB.ATKD.QMOD (One)
                    Store (Zero, FCNT)
                }
            }

            Return (One)
        }
    }
}
