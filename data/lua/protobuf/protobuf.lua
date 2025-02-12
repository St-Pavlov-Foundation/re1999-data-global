slot0 = setmetatable
slot1 = rawset
slot2 = rawget
slot3 = error
slot4 = ipairs
slot5 = pairs
slot6 = print
slot7 = table
slot8 = string
slot9 = tostring
slot10 = type
slot11 = logError
slot12 = require("pb")
slot13 = require("protobuf.wire_format")
slot14 = require("protobuf.type_checkers")
slot15 = require("protobuf.encoder")
slot16 = require("protobuf.decoder")
slot17 = require("protobuf.listener")
slot18 = require("protobuf.containers")
slot20 = require("protobuf.descriptor").FieldDescriptor
slot21 = require("protobuf.text_format")

module("protobuf.protobuf")

function slot22(slot0, slot1, slot2)
	slot3 = {
		__newindex = function (slot0, slot1, slot2)
			if uv0[slot1] then
				uv1(slot0, slot1, slot2)
			else
				uv2("error key: " .. slot1)
			end
		end,
		__index = slot3
	}

	function slot3.__call()
		return uv0({}, uv1)
	end

	_M[slot0] = uv2(slot1, slot3)
end

slot22("Descriptor", {}, {
	full_name = true,
	name = true,
	containing_type = true,
	is_extendable = true,
	extensions = true,
	fields = true,
	extension_ranges = true,
	nested_types = true,
	options = true,
	enum_types = true,
	filename = true
})
slot22("FieldDescriptor", slot20, {
	full_name = true,
	name = true,
	containing_type = true,
	type = true,
	index = true,
	label = true,
	default_value = true,
	number = true,
	extension_scope = true,
	is_extension = true,
	enum_type = true,
	has_default_value = true,
	message_type = true,
	cpp_type = true
})
slot22("EnumDescriptor", {}, {
	full_name = true,
	values = true,
	containing_type = true,
	name = true,
	options = true
})
slot22("EnumValueDescriptor", {}, {
	options = true,
	name = true,
	type = true,
	index = true,
	number = true
})

slot23 = {
	[slot20.TYPE_DOUBLE] = slot13.WIRETYPE_FIXED64,
	[slot20.TYPE_FLOAT] = slot13.WIRETYPE_FIXED32,
	[slot20.TYPE_INT64] = slot13.WIRETYPE_VARINT,
	[slot20.TYPE_UINT64] = slot13.WIRETYPE_VARINT,
	[slot20.TYPE_INT32] = slot13.WIRETYPE_VARINT,
	[slot20.TYPE_FIXED64] = slot13.WIRETYPE_FIXED64,
	[slot20.TYPE_FIXED32] = slot13.WIRETYPE_FIXED32,
	[slot20.TYPE_BOOL] = slot13.WIRETYPE_VARINT,
	[slot20.TYPE_STRING] = slot13.WIRETYPE_LENGTH_DELIMITED,
	[slot20.TYPE_GROUP] = slot13.WIRETYPE_START_GROUP,
	[slot20.TYPE_MESSAGE] = slot13.WIRETYPE_LENGTH_DELIMITED,
	[slot20.TYPE_BYTES] = slot13.WIRETYPE_LENGTH_DELIMITED,
	[slot20.TYPE_UINT32] = slot13.WIRETYPE_VARINT,
	[slot20.TYPE_ENUM] = slot13.WIRETYPE_VARINT,
	[slot20.TYPE_SFIXED32] = slot13.WIRETYPE_FIXED32,
	[slot20.TYPE_SFIXED64] = slot13.WIRETYPE_FIXED64,
	[slot20.TYPE_SINT32] = slot13.WIRETYPE_VARINT,
	[slot20.TYPE_SINT64] = slot13.WIRETYPE_VARINT
}
slot24 = {
	[slot20.TYPE_STRING] = true,
	[slot20.TYPE_GROUP] = true,
	[slot20.TYPE_MESSAGE] = true,
	[slot20.TYPE_BYTES] = true
}
slot25 = {
	[slot20.CPPTYPE_INT32] = slot14.Int32ValueChecker(),
	[slot20.CPPTYPE_INT64] = slot14.TypeChecker({
		string = true,
		number = true
	}),
	[slot20.CPPTYPE_UINT32] = slot14.Uint32ValueChecker(),
	[slot20.CPPTYPE_UINT64] = slot14.TypeChecker({
		string = true,
		number = true
	}),
	[slot20.CPPTYPE_DOUBLE] = slot14.TypeChecker({
		number = true
	}),
	[slot20.CPPTYPE_FLOAT] = slot14.TypeChecker({
		number = true
	}),
	[slot20.CPPTYPE_BOOL] = slot14.TypeChecker({
		boolean = true,
		int = true,
		bool = true
	}),
	[slot20.CPPTYPE_ENUM] = slot14.Int32ValueChecker(),
	[slot20.CPPTYPE_STRING] = slot14.TypeChecker({
		string = true
	})
}
slot26 = {
	[slot20.TYPE_DOUBLE] = slot13.DoubleByteSize,
	[slot20.TYPE_FLOAT] = slot13.FloatByteSize,
	[slot20.TYPE_INT64] = slot13.Int64ByteSize,
	[slot20.TYPE_UINT64] = slot13.UInt64ByteSize,
	[slot20.TYPE_INT32] = slot13.Int32ByteSize,
	[slot20.TYPE_FIXED64] = slot13.Fixed64ByteSize,
	[slot20.TYPE_FIXED32] = slot13.Fixed32ByteSize,
	[slot20.TYPE_BOOL] = slot13.BoolByteSize,
	[slot20.TYPE_STRING] = slot13.StringByteSize,
	[slot20.TYPE_GROUP] = slot13.GroupByteSize,
	[slot20.TYPE_MESSAGE] = slot13.MessageByteSize,
	[slot20.TYPE_BYTES] = slot13.BytesByteSize,
	[slot20.TYPE_UINT32] = slot13.UInt32ByteSize,
	[slot20.TYPE_ENUM] = slot13.EnumByteSize,
	[slot20.TYPE_SFIXED32] = slot13.SFixed32ByteSize,
	[slot20.TYPE_SFIXED64] = slot13.SFixed64ByteSize,
	[slot20.TYPE_SINT32] = slot13.SInt32ByteSize,
	[slot20.TYPE_SINT64] = slot13.SInt64ByteSize
}
slot27 = {
	[slot20.TYPE_DOUBLE] = slot15.DoubleEncoder,
	[slot20.TYPE_FLOAT] = slot15.FloatEncoder,
	[slot20.TYPE_INT64] = slot15.Int64Encoder,
	[slot20.TYPE_UINT64] = slot15.UInt64Encoder,
	[slot20.TYPE_INT32] = slot15.Int32Encoder,
	[slot20.TYPE_FIXED64] = slot15.Fixed64Encoder,
	[slot20.TYPE_FIXED32] = slot15.Fixed32Encoder,
	[slot20.TYPE_BOOL] = slot15.BoolEncoder,
	[slot20.TYPE_STRING] = slot15.StringEncoder,
	[slot20.TYPE_GROUP] = slot15.GroupEncoder,
	[slot20.TYPE_MESSAGE] = slot15.MessageEncoder,
	[slot20.TYPE_BYTES] = slot15.BytesEncoder,
	[slot20.TYPE_UINT32] = slot15.UInt32Encoder,
	[slot20.TYPE_ENUM] = slot15.EnumEncoder,
	[slot20.TYPE_SFIXED32] = slot15.SFixed32Encoder,
	[slot20.TYPE_SFIXED64] = slot15.SFixed64Encoder,
	[slot20.TYPE_SINT32] = slot15.SInt32Encoder,
	[slot20.TYPE_SINT64] = slot15.SInt64Encoder
}
slot28 = {
	[slot20.TYPE_DOUBLE] = slot15.DoubleSizer,
	[slot20.TYPE_FLOAT] = slot15.FloatSizer,
	[slot20.TYPE_INT64] = slot15.Int64Sizer,
	[slot20.TYPE_UINT64] = slot15.UInt64Sizer,
	[slot20.TYPE_INT32] = slot15.Int32Sizer,
	[slot20.TYPE_FIXED64] = slot15.Fixed64Sizer,
	[slot20.TYPE_FIXED32] = slot15.Fixed32Sizer,
	[slot20.TYPE_BOOL] = slot15.BoolSizer,
	[slot20.TYPE_STRING] = slot15.StringSizer,
	[slot20.TYPE_GROUP] = slot15.GroupSizer,
	[slot20.TYPE_MESSAGE] = slot15.MessageSizer,
	[slot20.TYPE_BYTES] = slot15.BytesSizer,
	[slot20.TYPE_UINT32] = slot15.UInt32Sizer,
	[slot20.TYPE_ENUM] = slot15.EnumSizer,
	[slot20.TYPE_SFIXED32] = slot15.SFixed32Sizer,
	[slot20.TYPE_SFIXED64] = slot15.SFixed64Sizer,
	[slot20.TYPE_SINT32] = slot15.SInt32Sizer,
	[slot20.TYPE_SINT64] = slot15.SInt64Sizer
}
slot29 = {
	[slot20.TYPE_DOUBLE] = slot16.DoubleDecoder,
	[slot20.TYPE_FLOAT] = slot16.FloatDecoder,
	[slot20.TYPE_INT64] = slot16.Int64Decoder,
	[slot20.TYPE_UINT64] = slot16.UInt64Decoder,
	[slot20.TYPE_INT32] = slot16.Int32Decoder,
	[slot20.TYPE_FIXED64] = slot16.Fixed64Decoder,
	[slot20.TYPE_FIXED32] = slot16.Fixed32Decoder,
	[slot20.TYPE_BOOL] = slot16.BoolDecoder,
	[slot20.TYPE_STRING] = slot16.StringDecoder,
	[slot20.TYPE_GROUP] = slot16.GroupDecoder,
	[slot20.TYPE_MESSAGE] = slot16.MessageDecoder,
	[slot20.TYPE_BYTES] = slot16.BytesDecoder,
	[slot20.TYPE_UINT32] = slot16.UInt32Decoder,
	[slot20.TYPE_ENUM] = slot16.EnumDecoder,
	[slot20.TYPE_SFIXED32] = slot16.SFixed32Decoder,
	[slot20.TYPE_SFIXED64] = slot16.SFixed64Decoder,
	[slot20.TYPE_SINT32] = slot16.SInt32Decoder,
	[slot20.TYPE_SINT64] = slot16.SInt64Decoder
}
slot30 = {
	[slot20.TYPE_DOUBLE] = slot13.WIRETYPE_FIXED64,
	[slot20.TYPE_FLOAT] = slot13.WIRETYPE_FIXED32,
	[slot20.TYPE_INT64] = slot13.WIRETYPE_VARINT,
	[slot20.TYPE_UINT64] = slot13.WIRETYPE_VARINT,
	[slot20.TYPE_INT32] = slot13.WIRETYPE_VARINT,
	[slot20.TYPE_FIXED64] = slot13.WIRETYPE_FIXED64,
	[slot20.TYPE_FIXED32] = slot13.WIRETYPE_FIXED32,
	[slot20.TYPE_BOOL] = slot13.WIRETYPE_VARINT,
	[slot20.TYPE_STRING] = slot13.WIRETYPE_LENGTH_DELIMITED,
	[slot20.TYPE_GROUP] = slot13.WIRETYPE_START_GROUP,
	[slot20.TYPE_MESSAGE] = slot13.WIRETYPE_LENGTH_DELIMITED,
	[slot20.TYPE_BYTES] = slot13.WIRETYPE_LENGTH_DELIMITED,
	[slot20.TYPE_UINT32] = slot13.WIRETYPE_VARINT,
	[slot20.TYPE_ENUM] = slot13.WIRETYPE_VARINT,
	[slot20.TYPE_SFIXED32] = slot13.WIRETYPE_FIXED32,
	[slot20.TYPE_SFIXED64] = slot13.WIRETYPE_FIXED64,
	[slot20.TYPE_SINT32] = slot13.WIRETYPE_VARINT,
	[slot20.TYPE_SINT64] = slot13.WIRETYPE_VARINT
}

function slot31(slot0)
	return uv0[slot0] == nil
end

function slot32(slot0, slot1)
	if slot0 == uv0.CPPTYPE_STRING and slot1 == uv0.TYPE_STRING then
		return uv1.UnicodeValueChecker()
	end

	return uv2[slot0]
end

function slot33(slot0)
	if slot0.label == uv0.LABEL_REPEATED then
		if uv1(slot0.default_value) ~= "table" or #slot0.default_value ~= 0 then
			uv2("Repeated field default value not empty list:" .. uv3(slot0.default_value))
		end

		if slot0.cpp_type == uv0.CPPTYPE_MESSAGE then
			slot1 = slot0.message_type

			return function (slot0)
				return uv0.RepeatedCompositeFieldContainer(slot0._listener_for_children, uv1)
			end
		else
			slot1 = uv5(slot0.cpp_type, slot0.type)

			return function (slot0)
				return uv0.RepeatedScalarFieldContainer(slot0._listener_for_children, uv1)
			end
		end
	end

	if slot0.cpp_type == uv0.CPPTYPE_MESSAGE then
		slot1 = slot0.message_type

		return function (slot0)
			result = uv0._concrete_class()

			result._SetListener(slot0._listener_for_children)

			return result
		end
	end

	return function (slot0)
		return uv0.default_value
	end
end

function slot34(slot0, slot1)
	slot2 = slot1.label == uv0.LABEL_REPEATED
	slot3 = slot1.has_options and slot1.GetOptions().packed

	uv1(slot1, "_encoder", uv2[slot1.type](slot1.number, slot2, slot3))
	uv1(slot1, "_sizer", uv3[slot1.type](slot1.number, slot2, slot3))
	uv1(slot1, "_default_constructor", uv4(slot1))
	function (slot0, slot1)
		uv2._decoders_by_tag[uv0.TagBytes(uv1.number, slot0)] = uv3[uv1.type](uv1.number, uv4, slot1, uv1, uv1._default_constructor)
	end(uv7[slot1.type], False)

	if slot2 and uv8(slot1.type) then
		slot4(uv9.WIRETYPE_LENGTH_DELIMITED, True)
	end
end

function slot35(slot0, slot1)
	for slot5, slot6 in uv0(slot0.enum_types) do
		for slot10, slot11 in uv0(slot6.values) do
			slot1._member[slot11.name] = slot11.number
		end
	end
end

function slot36(slot0)
	return function ()
		slot0 = {
			_cached_byte_size = 0,
			_cached_byte_size_dirty = false,
			_fields = {},
			_is_present_in_parent = false,
			_listener = uv0.NullMessageListener(),
			_listener_for_children = uv0.Listener(slot0),
			__cname = uv1._descriptor.name
		}

		return uv2(slot0, uv1)
	end
end

function slot37(slot0, slot1)
	slot2 = slot0.name

	slot1._getter[slot2] = function (slot0)
		if slot0._fields[uv0] == nil then
			slot0._fields[uv0] = uv0._default_constructor(slot0)

			if not slot0._cached_byte_size_dirty then
				uv1._member._Modified(slot0)
			end
		end

		return slot1
	end

	slot1._setter[slot2] = function (slot0)
		uv0("Assignment not allowed to repeated field \"" .. uv1 .. "\" in protocol message object.")
	end
end

function slot38(slot0, slot1)
	slot2 = slot0.name
	slot3 = slot0.message_type

	slot1._getter[slot2] = function (slot0)
		if slot0._fields[uv0] == nil then
			slot1 = uv1._concrete_class()

			slot1:_SetListener(slot0._listener_for_children)

			slot0._fields[uv0] = slot1

			if not slot0._cached_byte_size_dirty then
				uv2._member._Modified(slot0)
			end
		end

		return slot1
	end

	slot1._setter[slot2] = function (slot0, slot1)
		uv0("Assignment not allowed to composite field" .. uv1 .. "in protocol message object.")
	end
end

function slot39(slot0, slot1)
	slot2 = slot0.name
	slot3 = uv0(slot0.cpp_type, slot0.type)
	slot4 = slot0.default_value

	slot1._getter[slot2] = function (slot0)
		if slot0._fields[uv0] ~= nil then
			return slot0._fields[uv0]
		else
			return uv1
		end
	end

	slot1._setter[slot2] = function (slot0, slot1)
		uv0(slot1)

		slot0._fields[uv1] = slot1

		if not slot0._cached_byte_size_dirty then
			uv2._member._Modified(slot0)
		end
	end
end

function slot40(slot0, slot1)
	constant_name = slot0.name:upper() .. "_FIELD_NUMBER"
	slot1._member[constant_name] = slot0.number

	if slot0.label == uv0.LABEL_REPEATED then
		uv1(slot0, slot1)
	elseif slot0.cpp_type == uv0.CPPTYPE_MESSAGE then
		uv2(slot0, slot1)
	else
		uv3(slot0, slot1)
	end
end

slot41 = {
	__index = function (slot0, slot1)
		if uv0(slot0, "_extended_message")._fields[slot1] ~= nil then
			return slot3
		end

		if slot1.label == uv1.LABEL_REPEATED then
			slot3 = slot1._default_constructor(slot0._extended_message)
		elseif slot1.cpp_type == uv1.CPPTYPE_MESSAGE then
			slot1.message_type._concrete_class():_SetListener(slot2._listener_for_children)
		else
			return slot1.default_value
		end

		slot2._fields[slot1] = slot3

		return slot3
	end,
	__newindex = function (slot0, slot1, slot2)
		slot3 = uv0(slot0, "_extended_message")

		if slot1.label == uv1.LABEL_REPEATED or slot1.cpp_type == uv1.CPPTYPE_MESSAGE then
			uv2("Cannot assign to extension \"" .. slot1.full_name .. "\" because it is a repeated or composite type.")
		end

		uv3(slot1.cpp_type, slot1.type).CheckValue(slot2)

		slot3._fields[slot1] = slot2

		slot3._Modified()
	end
}

function slot42(slot0)
	return uv0({
		_extended_message = slot0
	}, uv1)
end

function slot43(slot0, slot1)
	for slot5, slot6 in uv0(slot0.fields) do
		uv1(slot6, slot1)
	end

	if slot0.is_extendable then
		function slot1._getter.Extensions(slot0)
			return uv0(slot0)
		end
	end
end

function slot44(slot0, slot1)
	for slot6, slot7 in uv0(slot0._extensions_by_name) do
		slot1._member[uv1.upper(slot6) .. "_FIELD_NUMBER"] = slot7.number
	end
end

function slot45(slot0)
	function slot0._member.RegisterExtension(slot0)
		slot0.containing_type = uv0._descriptor

		uv1(uv0, slot0)

		if uv0._extensions_by_number[slot0.number] == nil then
			uv0._extensions_by_number[slot0.number] = slot0
		else
			uv2(uv3.format("Extensions \"%s\" and \"%s\" both try to extend message type \"%s\" with field number %d.", slot0.full_name, actual_handle.full_name, uv0._descriptor.full_name, slot0.number))
		end

		uv0._extensions_by_name[slot0.full_name] = slot0
	end

	function slot0._member.FromString(slot0)
		slot1 = uv0._member.__call()

		slot1.MergeFromString(slot0)

		return slot1
	end
end

function slot46(slot0, slot1)
	if slot0.label == uv0.LABEL_REPEATED then
		return slot1
	elseif slot0.cpp_type == uv0.CPPTYPE_MESSAGE then
		return slot1._is_present_in_parent
	else
		return true
	end
end

function sortFunc(slot0, slot1)
	return slot0.index < slot1.index
end

function pairsByKeys(slot0, slot1)
	slot2 = {}

	for slot6 in uv0(slot0) do
		uv1.insert(slot2, slot6)
	end

	uv1.sort(slot2, slot1)

	slot3 = 0

	return function ()
		uv0 = uv0 + 1

		if uv1[uv0] == nil then
			return nil
		else
			return uv1[uv0], uv2[uv1[uv0]]
		end
	end
end

function slot47(slot0, slot1)
	function slot1._member.ListFields(slot0)
		return function (slot0)
			slot1, slot2, slot3 = pairsByKeys(uv0._fields, sortFunc)

			return function (slot0, slot1)
				while true do
					slot2, slot3 = uv0(slot0, slot1)

					if slot2 == nil then
						return
					elseif uv1(slot2, slot3) then
						return slot2, slot3
					end
				end
			end, slot2, slot3
		end(slot0._fields)
	end
end

function slot48(slot0, slot1)
	slot2 = {
		[slot7.name] = slot7
	}

	for slot6, slot7 in uv0(slot0.fields) do
		if slot7.label ~= uv1.LABEL_REPEATED then
			-- Nothing
		end
	end

	function slot1._member.HasField(slot0, slot1)
		field = uv0[slot1]

		if field == nil then
			uv1("Protocol message has no singular \"" .. slot1 .. "\" field.")
		end

		if field.cpp_type == uv2.CPPTYPE_MESSAGE then
			value = slot0._fields[field]

			return value ~= nil and value._is_present_in_parent
		else
			return slot0._fields[field] ~= nil
		end
	end
end

function slot49(slot0, slot1)
	slot2 = {
		[slot7.name] = slot7
	}

	for slot6, slot7 in uv0(slot0.fields) do
		if slot7.label ~= uv1.LABEL_REPEATED then
			-- Nothing
		end
	end

	function slot1._member.ClearField(slot0, slot1)
		field = uv0[slot1]

		if field == nil then
			uv1("Protocol message has no singular \"" .. slot1 .. "\" field.")
		end

		if slot0._fields[field] then
			slot0._fields[field] = nil
		end

		uv2._member._Modified(slot0)
	end
end

function slot50(slot0)
	function slot0._member.ClearExtension(slot0, slot1)
		if slot0._fields[slot1] == nil then
			slot0._fields[slot1] = nil
		end

		uv0._member._Modified(slot0)
	end
end

function slot51(slot0, slot1)
	function slot1._member.Clear(slot0)
		slot0._fields = {}

		uv0._member._Modified(slot0)
	end
end

function slot52(slot0)
	slot1 = uv0.msg_format

	function slot0.__tostring(slot0)
		return uv0(slot0)
	end
end

function slot53(slot0)
	function slot0._member.HasExtension(slot0, slot1)
		if slot1.label == uv0.LABEL_REPEATED then
			uv1(slot1.full_name .. " is repeated.")
		end

		if slot1.cpp_type == uv0.CPPTYPE_MESSAGE then
			value = slot0._fields[slot1]

			return value ~= nil and value._is_present_in_parent
		else
			return slot0._fields[slot1]
		end
	end
end

function slot54(slot0)
	function slot0._member._SetListener(slot0, slot1)
		if slot1 ~= nil then
			slot0._listener = uv0.NullMessageListener()
		else
			slot0._listener = slot1
		end
	end
end

function slot55(slot0, slot1)
	function slot1._member.ByteSize(slot0)
		if not slot0._cached_byte_size_dirty and slot0._cached_byte_size > 0 then
			return slot0._cached_byte_size
		end

		for slot5, slot6 in uv0._member.ListFields(slot0) do
			slot1 = slot5._sizer(slot6) + 0
		end

		slot0._cached_byte_size = slot1
		slot0._cached_byte_size_dirty = false
		slot0._listener_for_children.dirty = false

		return slot1
	end
end

function slot56(slot0, slot1)
	function slot1._member.SerializeToString(slot0)
		if not uv0._member.IsInitialized(slot0) then
			uv1("Message is missing required fields: " .. uv2.concat(uv0._member.FindInitializationErrors(slot0), ","))
		end

		return uv0._member.SerializePartialToString(slot0)
	end

	function slot1._member.SerializeToIOString(slot0, slot1)
		if not uv0._member.IsInitialized(slot0) then
			uv1("Message is missing required fields: " .. uv2.concat(uv0._member.FindInitializationErrors(slot0), ","))
		end

		return uv0._member.SerializePartialToIOString(slot0, slot1)
	end
end

function slot57(slot0, slot1)
	slot2 = uv0.concat

	function slot1._member._InternalSerialize(slot0, slot1)
		for slot5, slot6 in uv0._member.ListFields(slot0) do
			slot5._encoder(slot1, slot6)
		end
	end

	function slot1._member.SerializePartialToIOString(slot0, slot1)
		slot2 = slot1.write

		uv0(slot0, function (slot0)
			uv0(uv1, slot0)
		end)
	end

	function slot1._member.SerializePartialToString(slot0)
		uv0(slot0, function (slot0)
			uv0[#uv0 + 1] = slot0
		end)

		return uv1({})
	end
end

function slot58(slot0, slot1)
	slot2 = uv0.ReadTag
	slot3 = uv0.SkipField
	slot4 = slot1._decoders_by_tag

	function slot1._member._InternalParse(slot0, slot1, slot2, slot3)
		uv0._member._Modified(slot0)

		slot4 = slot0._fields
		slot5, slot6, slot7 = nil

		while slot2 ~= slot3 do
			slot8, slot6 = uv1(slot1, slot2)

			if uv2[slot8] == nil then
				if uv3(slot1, slot6, slot3, slot5) == -1 then
					return slot2
				end

				slot2 = slot6
			else
				slot2 = slot7(slot1, slot6, slot3, slot0, slot4)
			end
		end

		return slot2
	end

	function slot1._member.MergeFromString(slot0, slot1)
		slot2 = #slot1

		if uv0(slot0, slot1, 0, slot2) ~= slot2 then
			uv1("Unexpected end-group tag.")
		end

		return slot2
	end

	function slot1._member.ParseFromString(slot0, slot1)
		uv0._member.Clear(slot0)
		uv1(slot0, slot1)
	end
end

function slot59(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in uv0(slot0.fields) do
		if slot7.label == uv1.LABEL_REQUIRED then
			slot2[#slot2 + 1] = slot7
		end
	end

	function slot1._member.IsInitialized(slot0, slot1)
		for slot5, slot6 in uv0(uv1) do
			if slot0._fields[slot6] == nil or slot6.cpp_type == uv2.CPPTYPE_MESSAGE and not slot0._fields[slot6]._is_present_in_parent then
				if slot1 ~= nil then
					slot1[#slot1 + 1] = uv3._member.FindInitializationErrors(slot0)
				end

				return false
			end
		end

		for slot5, slot6 in uv4(slot0._fields) do
			if slot5.cpp_type == uv2.CPPTYPE_MESSAGE then
				if slot5.label == uv2.LABEL_REPEATED then
					for slot10, slot11 in uv0(slot6) do
						if not slot11:IsInitialized() then
							if slot1 ~= nil then
								slot1[#slot1 + 1] = uv3._member.FindInitializationErrors(slot0)
							end

							return false
						end
					end
				elseif slot6._is_present_in_parent and not slot6:IsInitialized() then
					if slot1 ~= nil then
						slot1[#slot1 + 1] = uv3._member.FindInitializationErrors(slot0)
					end

					return false
				end
			end
		end

		return true
	end

	function slot1._member.FindInitializationErrors(slot0)
		slot1 = {}

		for slot5, slot6 in uv0(uv1) do
			if not uv2._member.HasField(slot0, slot6.name) then
				slot1[#slot1 + 1] = slot6.name
			end
		end

		for slot5, slot6 in uv2._member.ListFields(slot0) do
			if slot5.cpp_type == uv3.CPPTYPE_MESSAGE then
				if slot5.is_extension then
					name = uv4.format("(%s)", slot5.full_name)
				else
					name = slot5.name
				end

				if slot5.label == uv3.LABEL_REPEATED then
					for slot10, slot11 in uv0(slot6) do
						slot15 = name
						slot16 = slot10
						prefix = uv4.format("%s[%d].", slot15, slot16)
						sub_errors = slot11:FindInitializationErrors()

						for slot15, slot16 in uv0(sub_errors) do
							slot1[#slot1 + 1] = prefix .. slot16
						end
					end
				else
					prefix = name .. "."
					sub_errors = slot6:FindInitializationErrors()

					for slot10, slot11 in uv0(sub_errors) do
						slot1[#slot1 + 1] = prefix .. slot11
					end
				end
			end
		end

		return slot1
	end
end

function slot60(slot0)
	slot1 = uv0.LABEL_REPEATED
	slot2 = uv0.CPPTYPE_MESSAGE

	function slot0._member.MergeFrom(slot0, slot1)
		assert(slot1 ~= slot0)
		uv0._member._Modified(slot0)

		slot2 = slot0._fields

		for slot6, slot7 in uv1(slot1._fields) do
			if slot6.label == uv2 or slot6.cpp_type == uv3 then
				field_value = slot2[slot6]

				if field_value == nil then
					field_value = slot6._default_constructor(slot0)
					slot2[slot6] = field_value
				end

				field_value:MergeFrom(slot7)
			else
				slot0._fields[slot6] = slot7
			end
		end
	end
end

function slot61(slot0, slot1)
	uv0(slot0, slot1)
	uv1(slot0, slot1)
	uv2(slot0, slot1)

	if slot0.is_extendable then
		uv3(slot1)
		uv4(slot1)
	end

	uv5(slot0, slot1)
	uv6(slot1)
	uv7(slot1)
	uv8(slot0, slot1)
	uv9(slot0, slot1)
	uv10(slot0, slot1)
	uv11(slot0, slot1)
	uv12(slot0, slot1)
	uv13(slot1)
end

function slot62(slot0)
	function slot1(slot0)
		if not slot0._cached_byte_size_dirty then
			slot0._cached_byte_size_dirty = true
			slot0._listener_for_children.dirty = true
			slot0._is_present_in_parent = true

			slot0._listener:Modified()
		end
	end

	slot0._member._Modified = slot1
	slot0._member.SetInParent = slot1
end

function slot63(slot0)
	slot1 = slot0._getter
	slot2 = slot0._member

	return function (slot0, slot1)
		if uv0[slot1] then
			return slot2(slot0)
		else
			return uv1[slot1]
		end
	end
end

function slot64(slot0)
	slot1 = slot0._setter

	return function (slot0, slot1, slot2)
		if uv0[slot1] then
			slot3(slot0, slot2)
		elseif uv1 then
			uv1(slot1 .. " not found")
		else
			uv2(slot1 .. " not found")
		end
	end
end

function _AddClassAttributesForNestedExtensions(slot0, slot1)
	for slot6, slot7 in uv0(slot0._extensions_by_name) do
		slot1._member[slot6] = slot7
	end
end

function _M.Message(slot0)
	slot1 = {
		_decoders_by_tag = {}
	}
	slot5 = "_extensions_by_name"
	slot6 = {}

	uv0(slot0, slot5, slot6)

	for slot5, slot6 in uv1(slot0.extensions) do
		slot0._extensions_by_name[slot6.name] = slot6
	end

	slot5 = "_extensions_by_number"
	slot6 = {}

	uv0(slot0, slot5, slot6)

	for slot5, slot6 in uv1(slot0.extensions) do
		slot0._extensions_by_number[slot6.number] = slot6
	end

	slot1._descriptor = slot0
	slot1._extensions_by_name = {}
	slot1._extensions_by_number = {}
	slot1._getter = {}
	slot1._setter = {}
	slot1._member = {
		__call = uv3(slot1),
		__index = slot1._member,
		type = uv2({}, slot1._member)
	}

	if uv4(slot0, "_concrete_class") == nil then
		slot6 = "_concrete_class"
		slot7 = slot2

		uv0(slot0, slot6, slot7)

		for slot6, slot7 in uv1(slot0.fields) do
			uv5(slot1, slot7)
		end
	end

	uv6(slot0, slot1)
	_AddClassAttributesForNestedExtensions(slot0, slot1)
	uv7(slot0, slot1)
	uv8(slot0, slot1)
	uv9(slot1)
	uv10(slot0, slot1)
	uv11(slot1)

	slot1.__index = uv12(slot1)
	slot1.__newindex = uv13(slot1)

	return slot2
end
