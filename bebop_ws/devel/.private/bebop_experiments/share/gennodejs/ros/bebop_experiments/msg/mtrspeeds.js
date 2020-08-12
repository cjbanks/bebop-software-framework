// Auto-generated. Do not edit!

// (in-package bebop_experiments.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class mtrspeeds {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.m_1 = null;
      this.m_2 = null;
      this.m_3 = null;
      this.m_4 = null;
    }
    else {
      if (initObj.hasOwnProperty('m_1')) {
        this.m_1 = initObj.m_1
      }
      else {
        this.m_1 = 0.0;
      }
      if (initObj.hasOwnProperty('m_2')) {
        this.m_2 = initObj.m_2
      }
      else {
        this.m_2 = 0.0;
      }
      if (initObj.hasOwnProperty('m_3')) {
        this.m_3 = initObj.m_3
      }
      else {
        this.m_3 = 0.0;
      }
      if (initObj.hasOwnProperty('m_4')) {
        this.m_4 = initObj.m_4
      }
      else {
        this.m_4 = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type mtrspeeds
    // Serialize message field [m_1]
    bufferOffset = _serializer.float64(obj.m_1, buffer, bufferOffset);
    // Serialize message field [m_2]
    bufferOffset = _serializer.float64(obj.m_2, buffer, bufferOffset);
    // Serialize message field [m_3]
    bufferOffset = _serializer.float64(obj.m_3, buffer, bufferOffset);
    // Serialize message field [m_4]
    bufferOffset = _serializer.float64(obj.m_4, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type mtrspeeds
    let len;
    let data = new mtrspeeds(null);
    // Deserialize message field [m_1]
    data.m_1 = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [m_2]
    data.m_2 = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [m_3]
    data.m_3 = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [m_4]
    data.m_4 = _deserializer.float64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 32;
  }

  static datatype() {
    // Returns string type for a message object
    return 'bebop_experiments/mtrspeeds';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '4159a6b337f9935f0d25263e50f2c72a';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float64 m_1
    float64 m_2
    float64 m_3
    float64 m_4
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new mtrspeeds(null);
    if (msg.m_1 !== undefined) {
      resolved.m_1 = msg.m_1;
    }
    else {
      resolved.m_1 = 0.0
    }

    if (msg.m_2 !== undefined) {
      resolved.m_2 = msg.m_2;
    }
    else {
      resolved.m_2 = 0.0
    }

    if (msg.m_3 !== undefined) {
      resolved.m_3 = msg.m_3;
    }
    else {
      resolved.m_3 = 0.0
    }

    if (msg.m_4 !== undefined) {
      resolved.m_4 = msg.m_4;
    }
    else {
      resolved.m_4 = 0.0
    }

    return resolved;
    }
};

module.exports = mtrspeeds;
