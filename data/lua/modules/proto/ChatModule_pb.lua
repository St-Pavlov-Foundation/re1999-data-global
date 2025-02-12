slot1 = require("protobuf.protobuf")

module("modules.proto.ChatModule_pb", package.seeall)

slot2 = {
	DELETEOFFLINEMSGREPLY_MSG = slot1.Descriptor(),
	REPORTREQUEST_MSG = slot1.Descriptor(),
	REPORTREQUESTREPORTEDUSERIDFIELD = slot1.FieldDescriptor(),
	REPORTREQUESTREPORTTYPEIDFIELD = slot1.FieldDescriptor(),
	REPORTREQUESTCONTENTFIELD = slot1.FieldDescriptor(),
	SENDMSGREPLY_MSG = slot1.Descriptor(),
	SENDMSGREPLYMESSAGEFIELD = slot1.FieldDescriptor(),
	SENDMSGREPLYCONTENTFIELD = slot1.FieldDescriptor(),
	SENDMSGREPLYCHANNELTYPEFIELD = slot1.FieldDescriptor(),
	SENDMSGREPLYMSGTYPEFIELD = slot1.FieldDescriptor(),
	SENDMSGREPLYEXTDATAFIELD = slot1.FieldDescriptor(),
	SENDMSGREQUEST_MSG = slot1.Descriptor(),
	SENDMSGREQUESTCHANNELTYPEFIELD = slot1.FieldDescriptor(),
	SENDMSGREQUESTRECIPIENTIDFIELD = slot1.FieldDescriptor(),
	SENDMSGREQUESTCONTENTFIELD = slot1.FieldDescriptor(),
	SENDMSGREQUESTMSGTYPEFIELD = slot1.FieldDescriptor(),
	SENDMSGREQUESTEXTDATAFIELD = slot1.FieldDescriptor(),
	CHATMSG_MSG = slot1.Descriptor(),
	CHATMSGMSGIDFIELD = slot1.FieldDescriptor(),
	CHATMSGCHANNELTYPEFIELD = slot1.FieldDescriptor(),
	CHATMSGSENDERIDFIELD = slot1.FieldDescriptor(),
	CHATMSGSENDERNAMEFIELD = slot1.FieldDescriptor(),
	CHATMSGPORTRAITFIELD = slot1.FieldDescriptor(),
	CHATMSGCONTENTFIELD = slot1.FieldDescriptor(),
	CHATMSGSENDTIMEFIELD = slot1.FieldDescriptor(),
	CHATMSGLEVELFIELD = slot1.FieldDescriptor(),
	CHATMSGRECIPIENTIDFIELD = slot1.FieldDescriptor(),
	CHATMSGMSGTYPEFIELD = slot1.FieldDescriptor(),
	CHATMSGEXTDATAFIELD = slot1.FieldDescriptor(),
	REPORTREPLY_MSG = slot1.Descriptor(),
	GETREPORTTYPEREQUEST_MSG = slot1.Descriptor(),
	CHATMSGPUSH_MSG = slot1.Descriptor(),
	CHATMSGPUSHMSGFIELD = slot1.FieldDescriptor(),
	WORDTESTREQUEST_MSG = slot1.Descriptor(),
	WORDTESTREQUESTCONTENTFIELD = slot1.FieldDescriptor(),
	GETREPORTTYPEREPLY_MSG = slot1.Descriptor(),
	GETREPORTTYPEREPLYREPORTTYPESFIELD = slot1.FieldDescriptor(),
	DELETEOFFLINEMSGREQUEST_MSG = slot1.Descriptor(),
	WORDTESTREPLY_MSG = slot1.Descriptor(),
	REPORTTYPE_MSG = slot1.Descriptor(),
	REPORTTYPEIDFIELD = slot1.FieldDescriptor(),
	REPORTTYPEDESCFIELD = slot1.FieldDescriptor()
}
slot2.DELETEOFFLINEMSGREPLY_MSG.name = "DeleteOfflineMsgReply"
slot2.DELETEOFFLINEMSGREPLY_MSG.full_name = ".DeleteOfflineMsgReply"
slot2.DELETEOFFLINEMSGREPLY_MSG.nested_types = {}
slot2.DELETEOFFLINEMSGREPLY_MSG.enum_types = {}
slot2.DELETEOFFLINEMSGREPLY_MSG.fields = {}
slot2.DELETEOFFLINEMSGREPLY_MSG.is_extendable = false
slot2.DELETEOFFLINEMSGREPLY_MSG.extensions = {}
slot2.REPORTREQUESTREPORTEDUSERIDFIELD.name = "reportedUserId"
slot2.REPORTREQUESTREPORTEDUSERIDFIELD.full_name = ".ReportRequest.reportedUserId"
slot2.REPORTREQUESTREPORTEDUSERIDFIELD.number = 1
slot2.REPORTREQUESTREPORTEDUSERIDFIELD.index = 0
slot2.REPORTREQUESTREPORTEDUSERIDFIELD.label = 1
slot2.REPORTREQUESTREPORTEDUSERIDFIELD.has_default_value = false
slot2.REPORTREQUESTREPORTEDUSERIDFIELD.default_value = 0
slot2.REPORTREQUESTREPORTEDUSERIDFIELD.type = 4
slot2.REPORTREQUESTREPORTEDUSERIDFIELD.cpp_type = 4
slot2.REPORTREQUESTREPORTTYPEIDFIELD.name = "reportTypeId"
slot2.REPORTREQUESTREPORTTYPEIDFIELD.full_name = ".ReportRequest.reportTypeId"
slot2.REPORTREQUESTREPORTTYPEIDFIELD.number = 2
slot2.REPORTREQUESTREPORTTYPEIDFIELD.index = 1
slot2.REPORTREQUESTREPORTTYPEIDFIELD.label = 1
slot2.REPORTREQUESTREPORTTYPEIDFIELD.has_default_value = false
slot2.REPORTREQUESTREPORTTYPEIDFIELD.default_value = 0
slot2.REPORTREQUESTREPORTTYPEIDFIELD.type = 5
slot2.REPORTREQUESTREPORTTYPEIDFIELD.cpp_type = 1
slot2.REPORTREQUESTCONTENTFIELD.name = "content"
slot2.REPORTREQUESTCONTENTFIELD.full_name = ".ReportRequest.content"
slot2.REPORTREQUESTCONTENTFIELD.number = 3
slot2.REPORTREQUESTCONTENTFIELD.index = 2
slot2.REPORTREQUESTCONTENTFIELD.label = 1
slot2.REPORTREQUESTCONTENTFIELD.has_default_value = false
slot2.REPORTREQUESTCONTENTFIELD.default_value = ""
slot2.REPORTREQUESTCONTENTFIELD.type = 9
slot2.REPORTREQUESTCONTENTFIELD.cpp_type = 9
slot2.REPORTREQUEST_MSG.name = "ReportRequest"
slot2.REPORTREQUEST_MSG.full_name = ".ReportRequest"
slot2.REPORTREQUEST_MSG.nested_types = {}
slot2.REPORTREQUEST_MSG.enum_types = {}
slot2.REPORTREQUEST_MSG.fields = {
	slot2.REPORTREQUESTREPORTEDUSERIDFIELD,
	slot2.REPORTREQUESTREPORTTYPEIDFIELD,
	slot2.REPORTREQUESTCONTENTFIELD
}
slot2.REPORTREQUEST_MSG.is_extendable = false
slot2.REPORTREQUEST_MSG.extensions = {}
slot2.SENDMSGREPLYMESSAGEFIELD.name = "message"
slot2.SENDMSGREPLYMESSAGEFIELD.full_name = ".SendMsgReply.message"
slot2.SENDMSGREPLYMESSAGEFIELD.number = 1
slot2.SENDMSGREPLYMESSAGEFIELD.index = 0
slot2.SENDMSGREPLYMESSAGEFIELD.label = 1
slot2.SENDMSGREPLYMESSAGEFIELD.has_default_value = false
slot2.SENDMSGREPLYMESSAGEFIELD.default_value = ""
slot2.SENDMSGREPLYMESSAGEFIELD.type = 9
slot2.SENDMSGREPLYMESSAGEFIELD.cpp_type = 9
slot2.SENDMSGREPLYCONTENTFIELD.name = "content"
slot2.SENDMSGREPLYCONTENTFIELD.full_name = ".SendMsgReply.content"
slot2.SENDMSGREPLYCONTENTFIELD.number = 2
slot2.SENDMSGREPLYCONTENTFIELD.index = 1
slot2.SENDMSGREPLYCONTENTFIELD.label = 1
slot2.SENDMSGREPLYCONTENTFIELD.has_default_value = false
slot2.SENDMSGREPLYCONTENTFIELD.default_value = ""
slot2.SENDMSGREPLYCONTENTFIELD.type = 9
slot2.SENDMSGREPLYCONTENTFIELD.cpp_type = 9
slot2.SENDMSGREPLYCHANNELTYPEFIELD.name = "channelType"
slot2.SENDMSGREPLYCHANNELTYPEFIELD.full_name = ".SendMsgReply.channelType"
slot2.SENDMSGREPLYCHANNELTYPEFIELD.number = 3
slot2.SENDMSGREPLYCHANNELTYPEFIELD.index = 2
slot2.SENDMSGREPLYCHANNELTYPEFIELD.label = 1
slot2.SENDMSGREPLYCHANNELTYPEFIELD.has_default_value = false
slot2.SENDMSGREPLYCHANNELTYPEFIELD.default_value = 0
slot2.SENDMSGREPLYCHANNELTYPEFIELD.type = 13
slot2.SENDMSGREPLYCHANNELTYPEFIELD.cpp_type = 3
slot2.SENDMSGREPLYMSGTYPEFIELD.name = "msgType"
slot2.SENDMSGREPLYMSGTYPEFIELD.full_name = ".SendMsgReply.msgType"
slot2.SENDMSGREPLYMSGTYPEFIELD.number = 4
slot2.SENDMSGREPLYMSGTYPEFIELD.index = 3
slot2.SENDMSGREPLYMSGTYPEFIELD.label = 1
slot2.SENDMSGREPLYMSGTYPEFIELD.has_default_value = false
slot2.SENDMSGREPLYMSGTYPEFIELD.default_value = 0
slot2.SENDMSGREPLYMSGTYPEFIELD.type = 5
slot2.SENDMSGREPLYMSGTYPEFIELD.cpp_type = 1
slot2.SENDMSGREPLYEXTDATAFIELD.name = "extData"
slot2.SENDMSGREPLYEXTDATAFIELD.full_name = ".SendMsgReply.extData"
slot2.SENDMSGREPLYEXTDATAFIELD.number = 5
slot2.SENDMSGREPLYEXTDATAFIELD.index = 4
slot2.SENDMSGREPLYEXTDATAFIELD.label = 1
slot2.SENDMSGREPLYEXTDATAFIELD.has_default_value = false
slot2.SENDMSGREPLYEXTDATAFIELD.default_value = ""
slot2.SENDMSGREPLYEXTDATAFIELD.type = 9
slot2.SENDMSGREPLYEXTDATAFIELD.cpp_type = 9
slot2.SENDMSGREPLY_MSG.name = "SendMsgReply"
slot2.SENDMSGREPLY_MSG.full_name = ".SendMsgReply"
slot2.SENDMSGREPLY_MSG.nested_types = {}
slot2.SENDMSGREPLY_MSG.enum_types = {}
slot2.SENDMSGREPLY_MSG.fields = {
	slot2.SENDMSGREPLYMESSAGEFIELD,
	slot2.SENDMSGREPLYCONTENTFIELD,
	slot2.SENDMSGREPLYCHANNELTYPEFIELD,
	slot2.SENDMSGREPLYMSGTYPEFIELD,
	slot2.SENDMSGREPLYEXTDATAFIELD
}
slot2.SENDMSGREPLY_MSG.is_extendable = false
slot2.SENDMSGREPLY_MSG.extensions = {}
slot2.SENDMSGREQUESTCHANNELTYPEFIELD.name = "channelType"
slot2.SENDMSGREQUESTCHANNELTYPEFIELD.full_name = ".SendMsgRequest.channelType"
slot2.SENDMSGREQUESTCHANNELTYPEFIELD.number = 1
slot2.SENDMSGREQUESTCHANNELTYPEFIELD.index = 0
slot2.SENDMSGREQUESTCHANNELTYPEFIELD.label = 1
slot2.SENDMSGREQUESTCHANNELTYPEFIELD.has_default_value = false
slot2.SENDMSGREQUESTCHANNELTYPEFIELD.default_value = 0
slot2.SENDMSGREQUESTCHANNELTYPEFIELD.type = 13
slot2.SENDMSGREQUESTCHANNELTYPEFIELD.cpp_type = 3
slot2.SENDMSGREQUESTRECIPIENTIDFIELD.name = "recipientId"
slot2.SENDMSGREQUESTRECIPIENTIDFIELD.full_name = ".SendMsgRequest.recipientId"
slot2.SENDMSGREQUESTRECIPIENTIDFIELD.number = 2
slot2.SENDMSGREQUESTRECIPIENTIDFIELD.index = 1
slot2.SENDMSGREQUESTRECIPIENTIDFIELD.label = 1
slot2.SENDMSGREQUESTRECIPIENTIDFIELD.has_default_value = false
slot2.SENDMSGREQUESTRECIPIENTIDFIELD.default_value = 0
slot2.SENDMSGREQUESTRECIPIENTIDFIELD.type = 4
slot2.SENDMSGREQUESTRECIPIENTIDFIELD.cpp_type = 4
slot2.SENDMSGREQUESTCONTENTFIELD.name = "content"
slot2.SENDMSGREQUESTCONTENTFIELD.full_name = ".SendMsgRequest.content"
slot2.SENDMSGREQUESTCONTENTFIELD.number = 3
slot2.SENDMSGREQUESTCONTENTFIELD.index = 2
slot2.SENDMSGREQUESTCONTENTFIELD.label = 1
slot2.SENDMSGREQUESTCONTENTFIELD.has_default_value = false
slot2.SENDMSGREQUESTCONTENTFIELD.default_value = ""
slot2.SENDMSGREQUESTCONTENTFIELD.type = 9
slot2.SENDMSGREQUESTCONTENTFIELD.cpp_type = 9
slot2.SENDMSGREQUESTMSGTYPEFIELD.name = "msgType"
slot2.SENDMSGREQUESTMSGTYPEFIELD.full_name = ".SendMsgRequest.msgType"
slot2.SENDMSGREQUESTMSGTYPEFIELD.number = 4
slot2.SENDMSGREQUESTMSGTYPEFIELD.index = 3
slot2.SENDMSGREQUESTMSGTYPEFIELD.label = 1
slot2.SENDMSGREQUESTMSGTYPEFIELD.has_default_value = false
slot2.SENDMSGREQUESTMSGTYPEFIELD.default_value = 0
slot2.SENDMSGREQUESTMSGTYPEFIELD.type = 5
slot2.SENDMSGREQUESTMSGTYPEFIELD.cpp_type = 1
slot2.SENDMSGREQUESTEXTDATAFIELD.name = "extData"
slot2.SENDMSGREQUESTEXTDATAFIELD.full_name = ".SendMsgRequest.extData"
slot2.SENDMSGREQUESTEXTDATAFIELD.number = 5
slot2.SENDMSGREQUESTEXTDATAFIELD.index = 4
slot2.SENDMSGREQUESTEXTDATAFIELD.label = 1
slot2.SENDMSGREQUESTEXTDATAFIELD.has_default_value = false
slot2.SENDMSGREQUESTEXTDATAFIELD.default_value = ""
slot2.SENDMSGREQUESTEXTDATAFIELD.type = 9
slot2.SENDMSGREQUESTEXTDATAFIELD.cpp_type = 9
slot2.SENDMSGREQUEST_MSG.name = "SendMsgRequest"
slot2.SENDMSGREQUEST_MSG.full_name = ".SendMsgRequest"
slot2.SENDMSGREQUEST_MSG.nested_types = {}
slot2.SENDMSGREQUEST_MSG.enum_types = {}
slot2.SENDMSGREQUEST_MSG.fields = {
	slot2.SENDMSGREQUESTCHANNELTYPEFIELD,
	slot2.SENDMSGREQUESTRECIPIENTIDFIELD,
	slot2.SENDMSGREQUESTCONTENTFIELD,
	slot2.SENDMSGREQUESTMSGTYPEFIELD,
	slot2.SENDMSGREQUESTEXTDATAFIELD
}
slot2.SENDMSGREQUEST_MSG.is_extendable = false
slot2.SENDMSGREQUEST_MSG.extensions = {}
slot2.CHATMSGMSGIDFIELD.name = "msgId"
slot2.CHATMSGMSGIDFIELD.full_name = ".ChatMsg.msgId"
slot2.CHATMSGMSGIDFIELD.number = 1
slot2.CHATMSGMSGIDFIELD.index = 0
slot2.CHATMSGMSGIDFIELD.label = 1
slot2.CHATMSGMSGIDFIELD.has_default_value = false
slot2.CHATMSGMSGIDFIELD.default_value = 0
slot2.CHATMSGMSGIDFIELD.type = 4
slot2.CHATMSGMSGIDFIELD.cpp_type = 4
slot2.CHATMSGCHANNELTYPEFIELD.name = "channelType"
slot2.CHATMSGCHANNELTYPEFIELD.full_name = ".ChatMsg.channelType"
slot2.CHATMSGCHANNELTYPEFIELD.number = 2
slot2.CHATMSGCHANNELTYPEFIELD.index = 1
slot2.CHATMSGCHANNELTYPEFIELD.label = 1
slot2.CHATMSGCHANNELTYPEFIELD.has_default_value = false
slot2.CHATMSGCHANNELTYPEFIELD.default_value = 0
slot2.CHATMSGCHANNELTYPEFIELD.type = 13
slot2.CHATMSGCHANNELTYPEFIELD.cpp_type = 3
slot2.CHATMSGSENDERIDFIELD.name = "senderId"
slot2.CHATMSGSENDERIDFIELD.full_name = ".ChatMsg.senderId"
slot2.CHATMSGSENDERIDFIELD.number = 3
slot2.CHATMSGSENDERIDFIELD.index = 2
slot2.CHATMSGSENDERIDFIELD.label = 1
slot2.CHATMSGSENDERIDFIELD.has_default_value = false
slot2.CHATMSGSENDERIDFIELD.default_value = 0
slot2.CHATMSGSENDERIDFIELD.type = 4
slot2.CHATMSGSENDERIDFIELD.cpp_type = 4
slot2.CHATMSGSENDERNAMEFIELD.name = "senderName"
slot2.CHATMSGSENDERNAMEFIELD.full_name = ".ChatMsg.senderName"
slot2.CHATMSGSENDERNAMEFIELD.number = 4
slot2.CHATMSGSENDERNAMEFIELD.index = 3
slot2.CHATMSGSENDERNAMEFIELD.label = 1
slot2.CHATMSGSENDERNAMEFIELD.has_default_value = false
slot2.CHATMSGSENDERNAMEFIELD.default_value = ""
slot2.CHATMSGSENDERNAMEFIELD.type = 9
slot2.CHATMSGSENDERNAMEFIELD.cpp_type = 9
slot2.CHATMSGPORTRAITFIELD.name = "portrait"
slot2.CHATMSGPORTRAITFIELD.full_name = ".ChatMsg.portrait"
slot2.CHATMSGPORTRAITFIELD.number = 5
slot2.CHATMSGPORTRAITFIELD.index = 4
slot2.CHATMSGPORTRAITFIELD.label = 1
slot2.CHATMSGPORTRAITFIELD.has_default_value = false
slot2.CHATMSGPORTRAITFIELD.default_value = 0
slot2.CHATMSGPORTRAITFIELD.type = 13
slot2.CHATMSGPORTRAITFIELD.cpp_type = 3
slot2.CHATMSGCONTENTFIELD.name = "content"
slot2.CHATMSGCONTENTFIELD.full_name = ".ChatMsg.content"
slot2.CHATMSGCONTENTFIELD.number = 6
slot2.CHATMSGCONTENTFIELD.index = 5
slot2.CHATMSGCONTENTFIELD.label = 1
slot2.CHATMSGCONTENTFIELD.has_default_value = false
slot2.CHATMSGCONTENTFIELD.default_value = ""
slot2.CHATMSGCONTENTFIELD.type = 9
slot2.CHATMSGCONTENTFIELD.cpp_type = 9
slot2.CHATMSGSENDTIMEFIELD.name = "sendTime"
slot2.CHATMSGSENDTIMEFIELD.full_name = ".ChatMsg.sendTime"
slot2.CHATMSGSENDTIMEFIELD.number = 7
slot2.CHATMSGSENDTIMEFIELD.index = 6
slot2.CHATMSGSENDTIMEFIELD.label = 1
slot2.CHATMSGSENDTIMEFIELD.has_default_value = false
slot2.CHATMSGSENDTIMEFIELD.default_value = 0
slot2.CHATMSGSENDTIMEFIELD.type = 4
slot2.CHATMSGSENDTIMEFIELD.cpp_type = 4
slot2.CHATMSGLEVELFIELD.name = "level"
slot2.CHATMSGLEVELFIELD.full_name = ".ChatMsg.level"
slot2.CHATMSGLEVELFIELD.number = 8
slot2.CHATMSGLEVELFIELD.index = 7
slot2.CHATMSGLEVELFIELD.label = 1
slot2.CHATMSGLEVELFIELD.has_default_value = false
slot2.CHATMSGLEVELFIELD.default_value = 0
slot2.CHATMSGLEVELFIELD.type = 13
slot2.CHATMSGLEVELFIELD.cpp_type = 3
slot2.CHATMSGRECIPIENTIDFIELD.name = "recipientId"
slot2.CHATMSGRECIPIENTIDFIELD.full_name = ".ChatMsg.recipientId"
slot2.CHATMSGRECIPIENTIDFIELD.number = 9
slot2.CHATMSGRECIPIENTIDFIELD.index = 8
slot2.CHATMSGRECIPIENTIDFIELD.label = 1
slot2.CHATMSGRECIPIENTIDFIELD.has_default_value = false
slot2.CHATMSGRECIPIENTIDFIELD.default_value = 0
slot2.CHATMSGRECIPIENTIDFIELD.type = 4
slot2.CHATMSGRECIPIENTIDFIELD.cpp_type = 4
slot2.CHATMSGMSGTYPEFIELD.name = "msgType"
slot2.CHATMSGMSGTYPEFIELD.full_name = ".ChatMsg.msgType"
slot2.CHATMSGMSGTYPEFIELD.number = 10
slot2.CHATMSGMSGTYPEFIELD.index = 9
slot2.CHATMSGMSGTYPEFIELD.label = 1
slot2.CHATMSGMSGTYPEFIELD.has_default_value = false
slot2.CHATMSGMSGTYPEFIELD.default_value = 0
slot2.CHATMSGMSGTYPEFIELD.type = 5
slot2.CHATMSGMSGTYPEFIELD.cpp_type = 1
slot2.CHATMSGEXTDATAFIELD.name = "extData"
slot2.CHATMSGEXTDATAFIELD.full_name = ".ChatMsg.extData"
slot2.CHATMSGEXTDATAFIELD.number = 11
slot2.CHATMSGEXTDATAFIELD.index = 10
slot2.CHATMSGEXTDATAFIELD.label = 1
slot2.CHATMSGEXTDATAFIELD.has_default_value = false
slot2.CHATMSGEXTDATAFIELD.default_value = ""
slot2.CHATMSGEXTDATAFIELD.type = 9
slot2.CHATMSGEXTDATAFIELD.cpp_type = 9
slot2.CHATMSG_MSG.name = "ChatMsg"
slot2.CHATMSG_MSG.full_name = ".ChatMsg"
slot2.CHATMSG_MSG.nested_types = {}
slot2.CHATMSG_MSG.enum_types = {}
slot2.CHATMSG_MSG.fields = {
	slot2.CHATMSGMSGIDFIELD,
	slot2.CHATMSGCHANNELTYPEFIELD,
	slot2.CHATMSGSENDERIDFIELD,
	slot2.CHATMSGSENDERNAMEFIELD,
	slot2.CHATMSGPORTRAITFIELD,
	slot2.CHATMSGCONTENTFIELD,
	slot2.CHATMSGSENDTIMEFIELD,
	slot2.CHATMSGLEVELFIELD,
	slot2.CHATMSGRECIPIENTIDFIELD,
	slot2.CHATMSGMSGTYPEFIELD,
	slot2.CHATMSGEXTDATAFIELD
}
slot2.CHATMSG_MSG.is_extendable = false
slot2.CHATMSG_MSG.extensions = {}
slot2.REPORTREPLY_MSG.name = "ReportReply"
slot2.REPORTREPLY_MSG.full_name = ".ReportReply"
slot2.REPORTREPLY_MSG.nested_types = {}
slot2.REPORTREPLY_MSG.enum_types = {}
slot2.REPORTREPLY_MSG.fields = {}
slot2.REPORTREPLY_MSG.is_extendable = false
slot2.REPORTREPLY_MSG.extensions = {}
slot2.GETREPORTTYPEREQUEST_MSG.name = "GetReportTypeRequest"
slot2.GETREPORTTYPEREQUEST_MSG.full_name = ".GetReportTypeRequest"
slot2.GETREPORTTYPEREQUEST_MSG.nested_types = {}
slot2.GETREPORTTYPEREQUEST_MSG.enum_types = {}
slot2.GETREPORTTYPEREQUEST_MSG.fields = {}
slot2.GETREPORTTYPEREQUEST_MSG.is_extendable = false
slot2.GETREPORTTYPEREQUEST_MSG.extensions = {}
slot2.CHATMSGPUSHMSGFIELD.name = "msg"
slot2.CHATMSGPUSHMSGFIELD.full_name = ".ChatMsgPush.msg"
slot2.CHATMSGPUSHMSGFIELD.number = 1
slot2.CHATMSGPUSHMSGFIELD.index = 0
slot2.CHATMSGPUSHMSGFIELD.label = 3
slot2.CHATMSGPUSHMSGFIELD.has_default_value = false
slot2.CHATMSGPUSHMSGFIELD.default_value = {}
slot2.CHATMSGPUSHMSGFIELD.message_type = slot2.CHATMSG_MSG
slot2.CHATMSGPUSHMSGFIELD.type = 11
slot2.CHATMSGPUSHMSGFIELD.cpp_type = 10
slot2.CHATMSGPUSH_MSG.name = "ChatMsgPush"
slot2.CHATMSGPUSH_MSG.full_name = ".ChatMsgPush"
slot2.CHATMSGPUSH_MSG.nested_types = {}
slot2.CHATMSGPUSH_MSG.enum_types = {}
slot2.CHATMSGPUSH_MSG.fields = {
	slot2.CHATMSGPUSHMSGFIELD
}
slot2.CHATMSGPUSH_MSG.is_extendable = false
slot2.CHATMSGPUSH_MSG.extensions = {}
slot2.WORDTESTREQUESTCONTENTFIELD.name = "content"
slot2.WORDTESTREQUESTCONTENTFIELD.full_name = ".WordTestRequest.content"
slot2.WORDTESTREQUESTCONTENTFIELD.number = 1
slot2.WORDTESTREQUESTCONTENTFIELD.index = 0
slot2.WORDTESTREQUESTCONTENTFIELD.label = 1
slot2.WORDTESTREQUESTCONTENTFIELD.has_default_value = false
slot2.WORDTESTREQUESTCONTENTFIELD.default_value = ""
slot2.WORDTESTREQUESTCONTENTFIELD.type = 9
slot2.WORDTESTREQUESTCONTENTFIELD.cpp_type = 9
slot2.WORDTESTREQUEST_MSG.name = "WordTestRequest"
slot2.WORDTESTREQUEST_MSG.full_name = ".WordTestRequest"
slot2.WORDTESTREQUEST_MSG.nested_types = {}
slot2.WORDTESTREQUEST_MSG.enum_types = {}
slot2.WORDTESTREQUEST_MSG.fields = {
	slot2.WORDTESTREQUESTCONTENTFIELD
}
slot2.WORDTESTREQUEST_MSG.is_extendable = false
slot2.WORDTESTREQUEST_MSG.extensions = {}
slot2.GETREPORTTYPEREPLYREPORTTYPESFIELD.name = "reportTypes"
slot2.GETREPORTTYPEREPLYREPORTTYPESFIELD.full_name = ".GetReportTypeReply.reportTypes"
slot2.GETREPORTTYPEREPLYREPORTTYPESFIELD.number = 1
slot2.GETREPORTTYPEREPLYREPORTTYPESFIELD.index = 0
slot2.GETREPORTTYPEREPLYREPORTTYPESFIELD.label = 3
slot2.GETREPORTTYPEREPLYREPORTTYPESFIELD.has_default_value = false
slot2.GETREPORTTYPEREPLYREPORTTYPESFIELD.default_value = {}
slot2.GETREPORTTYPEREPLYREPORTTYPESFIELD.message_type = slot2.REPORTTYPE_MSG
slot2.GETREPORTTYPEREPLYREPORTTYPESFIELD.type = 11
slot2.GETREPORTTYPEREPLYREPORTTYPESFIELD.cpp_type = 10
slot2.GETREPORTTYPEREPLY_MSG.name = "GetReportTypeReply"
slot2.GETREPORTTYPEREPLY_MSG.full_name = ".GetReportTypeReply"
slot2.GETREPORTTYPEREPLY_MSG.nested_types = {}
slot2.GETREPORTTYPEREPLY_MSG.enum_types = {}
slot2.GETREPORTTYPEREPLY_MSG.fields = {
	slot2.GETREPORTTYPEREPLYREPORTTYPESFIELD
}
slot2.GETREPORTTYPEREPLY_MSG.is_extendable = false
slot2.GETREPORTTYPEREPLY_MSG.extensions = {}
slot2.DELETEOFFLINEMSGREQUEST_MSG.name = "DeleteOfflineMsgRequest"
slot2.DELETEOFFLINEMSGREQUEST_MSG.full_name = ".DeleteOfflineMsgRequest"
slot2.DELETEOFFLINEMSGREQUEST_MSG.nested_types = {}
slot2.DELETEOFFLINEMSGREQUEST_MSG.enum_types = {}
slot2.DELETEOFFLINEMSGREQUEST_MSG.fields = {}
slot2.DELETEOFFLINEMSGREQUEST_MSG.is_extendable = false
slot2.DELETEOFFLINEMSGREQUEST_MSG.extensions = {}
slot2.WORDTESTREPLY_MSG.name = "WordTestReply"
slot2.WORDTESTREPLY_MSG.full_name = ".WordTestReply"
slot2.WORDTESTREPLY_MSG.nested_types = {}
slot2.WORDTESTREPLY_MSG.enum_types = {}
slot2.WORDTESTREPLY_MSG.fields = {}
slot2.WORDTESTREPLY_MSG.is_extendable = false
slot2.WORDTESTREPLY_MSG.extensions = {}
slot2.REPORTTYPEIDFIELD.name = "id"
slot2.REPORTTYPEIDFIELD.full_name = ".ReportType.id"
slot2.REPORTTYPEIDFIELD.number = 1
slot2.REPORTTYPEIDFIELD.index = 0
slot2.REPORTTYPEIDFIELD.label = 1
slot2.REPORTTYPEIDFIELD.has_default_value = false
slot2.REPORTTYPEIDFIELD.default_value = 0
slot2.REPORTTYPEIDFIELD.type = 5
slot2.REPORTTYPEIDFIELD.cpp_type = 1
slot2.REPORTTYPEDESCFIELD.name = "desc"
slot2.REPORTTYPEDESCFIELD.full_name = ".ReportType.desc"
slot2.REPORTTYPEDESCFIELD.number = 2
slot2.REPORTTYPEDESCFIELD.index = 1
slot2.REPORTTYPEDESCFIELD.label = 1
slot2.REPORTTYPEDESCFIELD.has_default_value = false
slot2.REPORTTYPEDESCFIELD.default_value = ""
slot2.REPORTTYPEDESCFIELD.type = 9
slot2.REPORTTYPEDESCFIELD.cpp_type = 9
slot2.REPORTTYPE_MSG.name = "ReportType"
slot2.REPORTTYPE_MSG.full_name = ".ReportType"
slot2.REPORTTYPE_MSG.nested_types = {}
slot2.REPORTTYPE_MSG.enum_types = {}
slot2.REPORTTYPE_MSG.fields = {
	slot2.REPORTTYPEIDFIELD,
	slot2.REPORTTYPEDESCFIELD
}
slot2.REPORTTYPE_MSG.is_extendable = false
slot2.REPORTTYPE_MSG.extensions = {}
slot2.ChatMsg = slot1.Message(slot2.CHATMSG_MSG)
slot2.ChatMsgPush = slot1.Message(slot2.CHATMSGPUSH_MSG)
slot2.DeleteOfflineMsgReply = slot1.Message(slot2.DELETEOFFLINEMSGREPLY_MSG)
slot2.DeleteOfflineMsgRequest = slot1.Message(slot2.DELETEOFFLINEMSGREQUEST_MSG)
slot2.GetReportTypeReply = slot1.Message(slot2.GETREPORTTYPEREPLY_MSG)
slot2.GetReportTypeRequest = slot1.Message(slot2.GETREPORTTYPEREQUEST_MSG)
slot2.ReportReply = slot1.Message(slot2.REPORTREPLY_MSG)
slot2.ReportRequest = slot1.Message(slot2.REPORTREQUEST_MSG)
slot2.ReportType = slot1.Message(slot2.REPORTTYPE_MSG)
slot2.SendMsgReply = slot1.Message(slot2.SENDMSGREPLY_MSG)
slot2.SendMsgRequest = slot1.Message(slot2.SENDMSGREQUEST_MSG)
slot2.WordTestReply = slot1.Message(slot2.WORDTESTREPLY_MSG)
slot2.WordTestRequest = slot1.Message(slot2.WORDTESTREQUEST_MSG)

return slot2
