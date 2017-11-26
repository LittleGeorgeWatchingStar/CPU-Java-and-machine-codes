package arch.sm213.machine.student;

import machine.AbstractMainMemory;
import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.*;

/**
 * Created by Stephen on 1/10/17.
 */
public class MainMemoryTest {
    private MainMemory testMem;

    //GOAL: Initialize a memory that has 64 bytes of capacity
    @Before
    public void runBeforeAllTests() {
        testMem = new MainMemory(64);
    }

    //GOAL: to test a situation that an address is not aligned to a length.
    @Test
    public void testisAccessAlignedFalse() {
        assertFalse(testMem.isAccessAligned(8,3));
    }

    //GOAL: to test a situation that an address is aligned to a length.
    @Test
    public void testIsAccessAlignedTrue0() {
        assertTrue(testMem.isAccessAligned(8,2));
    }

    //GOAL: to test a situation that an address is aligned to another length.
    @Test
    public void testIsAccessAlignedTrue1() {
        assertTrue(testMem.isAccessAligned(16,4));
    }

    //GOAL: to test that an array of four bytes can be turned into a Big Endian integer.
    @Test
    public void testBytesToInteger() {
        int bigEdian = testMem.bytesToInteger((byte) 0x00,(byte) 0x00,(byte) 0x00,(byte) 0x01);
        assertEquals(1,bigEdian);
        bigEdian = testMem.bytesToInteger((byte) 0x00,(byte) 0x00,(byte) 0x00,(byte) 0x4F);
        assertEquals(79,bigEdian);
        bigEdian = testMem.bytesToInteger((byte) 0x00,(byte) 0x77,(byte) 0x41,(byte) 0x8C);
        assertEquals(7815564,bigEdian);
        bigEdian = testMem.bytesToInteger((byte) 0x15,(byte) 0x53,(byte) 0xD5,(byte) 0x0C);
        assertEquals(357815564,bigEdian);
        bigEdian = testMem.bytesToInteger((byte) 0xE5,(byte) 0x1E,(byte) 0x10,(byte) 0xE9);
        assertEquals(-451014423,bigEdian);
    }

    //GOAL: to test that a Big Endian can be converted into an array of four bytes
    @Test
    public void testIntegerToBytes0() {
        byte[] testB = testMem.integerToBytes(90);
        assertEquals(testB[0],(byte) 0x00);
        assertEquals(testB[1],(byte) 0x00);
        assertEquals(testB[2],(byte) 0x00);
        assertEquals(testB[3],(byte) 0x5A);
    }

    //GOAL: to test that a Big Endian can be converted into an array of four bytes
    @Test
    public void testIntegerToBytes1() {
        byte[] testB = testMem.integerToBytes(258490);
        assertEquals(testB[0],(byte) 0x00);
        assertEquals(testB[1],(byte) 0x03);
        assertEquals(testB[2],(byte) 0xF1);
        assertEquals(testB[3],(byte) 0xBA);
    }

    //GOAL: to test that a large Big Endian can be converted into an array of four bytes
    @Test
    public void testIntegerToBytes2() {
        byte[] testB = testMem.integerToBytes(25680245);
        assertEquals(testB[0],(byte) 0x01);
        assertEquals(testB[1],(byte) 0x87);
        assertEquals(testB[2],(byte) 0xD9);
        assertEquals(testB[3],(byte) 0x75);
    }

    //GOAL: to test that a negative Big Endian can be converted into an array of four bytes
    @Test
    public void testIntegerToBytes3() {
        byte[] testB = testMem.integerToBytes(-52806);
        assertEquals(testB[0],(byte) 0xFF);
        assertEquals(testB[1],(byte) 0xFF);
        assertEquals(testB[2],(byte) 0x31);
        assertEquals(testB[3],(byte) 0xBA);
    }

    //GOAL: to test the situation that the address to set is smaller than the memory has, and generate exception
    @Test (expected = AbstractMainMemory.InvalidAddressException.class)
    public void testSetValueNegativeAddress() throws AbstractMainMemory.InvalidAddressException {
        byte[] testB = new byte[]{(byte) 0x04,(byte) 0x32,(byte) 0x2D,(byte) 0x45};
        int addressToBegin = -5;
        testMem.set(addressToBegin,testB);
    }

    //GOAL: to test the situation that the address to set is bigger than the memory has, and generate exception
    @Test (expected = AbstractMainMemory.InvalidAddressException.class)
    public void testSetValueAddressTooBig() throws AbstractMainMemory.InvalidAddressException {
        byte[] testB = new byte[]{(byte) 0x04,(byte) 0x32,(byte) 0x2D,(byte) 0x45};
        int addressToBegin = 66;
        testMem.set(addressToBegin,testB);
    }

    //GOAL: to test an array of values can be set into legal addresses of the memory
    @Test
    public void testSetValue() throws AbstractMainMemory.InvalidAddressException {
        int addressToBegin = 4;
        int length = 4;

        byte[] testB = new byte[4];
        testB[0] = (byte) 0x04;
        testB[1] = (byte) 0x32;
        testB[2] = (byte) 0x2D;
        testB[3] = (byte) 0x45;

        testMem.set(addressToBegin,testB);

        byte[] returnB = testMem.get(addressToBegin,length);
        for(int i = 0; i < 4; i++) {
            assertEquals(testB[i], returnB[i]);
        }
    }

    //GOAL: to test the situation that the address to get value is smaller than the memory has, and generate exception
    @Test (expected = AbstractMainMemory.InvalidAddressException.class)
    public void testGetValueNegativeAddress() throws AbstractMainMemory.InvalidAddressException{
        int addressToBegin = -4;
        int length = 4;

        byte[] testB = new byte[]{(byte) 0x04,(byte) 0x32,(byte) 0x2D,(byte) 0x45};

        testMem.set(addressToBegin,testB);
        testMem.get(addressToBegin,length);
    }

    //GOAL: to test the situation that the address to get value is bigger than the memory has, and generate exception
    @Test (expected = AbstractMainMemory.InvalidAddressException.class)
    public void testGetValueAddressTooBig() throws AbstractMainMemory.InvalidAddressException{
        int addressToBegin = 90;
        int length = 4;

        byte[] testB = new byte[]{(byte) 0x04,(byte) 0x32,(byte) 0x2D,(byte) 0x45};

        testMem.set(addressToBegin,testB);
        testMem.get(addressToBegin,length);
    }

    //GOAL: to test an array of values in legal addresses can be obtained from the memory
    @Test
    public void testGetValue() throws AbstractMainMemory.InvalidAddressException{
        int addressToBegin = 6;
        int length = 5;

        byte[] testB = new byte[5];
        testB[0] = (byte) 0x04;
        testB[1] = (byte) 0x82;
        testB[2] = (byte) 0x7D;
        testB[3] = (byte) 0x45;
        testB[4] = (byte) 0x65;

        testMem.set(addressToBegin,testB);

        byte[] returnB = testMem.get(addressToBegin,length);
        for(int i = 0; i < 5; i++) {
            assertEquals(testB[i], returnB[i]);
        }
    }
}