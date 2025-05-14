local var_0_0 = require("protobuf.protobuf")

module("modules.proto.MailModule_pb", package.seeall)

local var_0_1 = {
	NEWMAILPUSH_MSG = var_0_0.Descriptor(),
	NEWMAILPUSHMAILFIELD = var_0_0.FieldDescriptor(),
	READMAILBATCHREQUEST_MSG = var_0_0.Descriptor(),
	READMAILBATCHREQUESTTYPEFIELD = var_0_0.FieldDescriptor(),
	DELETEMAILBATCHREQUEST_MSG = var_0_0.Descriptor(),
	DELETEMAILBATCHREQUESTTYPEFIELD = var_0_0.FieldDescriptor(),
	READMAILREPLY_MSG = var_0_0.Descriptor(),
	READMAILREPLYINCRIDFIELD = var_0_0.FieldDescriptor(),
	MARKMAILJUMPREQUEST_MSG = var_0_0.Descriptor(),
	MARKMAILJUMPREQUESTINCRIDFIELD = var_0_0.FieldDescriptor(),
	DELETEMAILBATCHREPLY_MSG = var_0_0.Descriptor(),
	DELETEMAILBATCHREPLYINCRIDSFIELD = var_0_0.FieldDescriptor(),
	MARKMAILJUMPREPLY_MSG = var_0_0.Descriptor(),
	MARKMAILJUMPREPLYINCRIDFIELD = var_0_0.FieldDescriptor(),
	READMAILREQUEST_MSG = var_0_0.Descriptor(),
	READMAILREQUESTINCRIDFIELD = var_0_0.FieldDescriptor(),
	GETALLMAILSREPLY_MSG = var_0_0.Descriptor(),
	GETALLMAILSREPLYMAILSFIELD = var_0_0.FieldDescriptor(),
	MAIL_MSG = var_0_0.Descriptor(),
	MAILINCRIDFIELD = var_0_0.FieldDescriptor(),
	MAILMAILIDFIELD = var_0_0.FieldDescriptor(),
	MAILPARAMSFIELD = var_0_0.FieldDescriptor(),
	MAILATTACHMENTFIELD = var_0_0.FieldDescriptor(),
	MAILSTATEFIELD = var_0_0.FieldDescriptor(),
	MAILCREATETIMEFIELD = var_0_0.FieldDescriptor(),
	MAILSENDERFIELD = var_0_0.FieldDescriptor(),
	MAILTITLEFIELD = var_0_0.FieldDescriptor(),
	MAILCONTENTFIELD = var_0_0.FieldDescriptor(),
	MAILCOPYFIELD = var_0_0.FieldDescriptor(),
	MAILEXPIRETIMEFIELD = var_0_0.FieldDescriptor(),
	MAILSENDERTYPEFIELD = var_0_0.FieldDescriptor(),
	MAILJUMPTITLEFIELD = var_0_0.FieldDescriptor(),
	MAILJUMPFIELD = var_0_0.FieldDescriptor(),
	DELETEMAILSPUSH_MSG = var_0_0.Descriptor(),
	DELETEMAILSPUSHINCRIDSFIELD = var_0_0.FieldDescriptor(),
	GETALLMAILSREQUEST_MSG = var_0_0.Descriptor(),
	AUTOREADMAILPUSH_MSG = var_0_0.Descriptor(),
	AUTOREADMAILPUSHINCRIDSFIELD = var_0_0.FieldDescriptor(),
	READMAILBATCHREPLY_MSG = var_0_0.Descriptor(),
	READMAILBATCHREPLYINCRIDSFIELD = var_0_0.FieldDescriptor()
}

var_0_1.NEWMAILPUSHMAILFIELD.name = "mail"
var_0_1.NEWMAILPUSHMAILFIELD.full_name = ".NewMailPush.mail"
var_0_1.NEWMAILPUSHMAILFIELD.number = 1
var_0_1.NEWMAILPUSHMAILFIELD.index = 0
var_0_1.NEWMAILPUSHMAILFIELD.label = 1
var_0_1.NEWMAILPUSHMAILFIELD.has_default_value = false
var_0_1.NEWMAILPUSHMAILFIELD.default_value = nil
var_0_1.NEWMAILPUSHMAILFIELD.message_type = var_0_1.MAIL_MSG
var_0_1.NEWMAILPUSHMAILFIELD.type = 11
var_0_1.NEWMAILPUSHMAILFIELD.cpp_type = 10
var_0_1.NEWMAILPUSH_MSG.name = "NewMailPush"
var_0_1.NEWMAILPUSH_MSG.full_name = ".NewMailPush"
var_0_1.NEWMAILPUSH_MSG.nested_types = {}
var_0_1.NEWMAILPUSH_MSG.enum_types = {}
var_0_1.NEWMAILPUSH_MSG.fields = {
	var_0_1.NEWMAILPUSHMAILFIELD
}
var_0_1.NEWMAILPUSH_MSG.is_extendable = false
var_0_1.NEWMAILPUSH_MSG.extensions = {}
var_0_1.READMAILBATCHREQUESTTYPEFIELD.name = "type"
var_0_1.READMAILBATCHREQUESTTYPEFIELD.full_name = ".ReadMailBatchRequest.type"
var_0_1.READMAILBATCHREQUESTTYPEFIELD.number = 1
var_0_1.READMAILBATCHREQUESTTYPEFIELD.index = 0
var_0_1.READMAILBATCHREQUESTTYPEFIELD.label = 1
var_0_1.READMAILBATCHREQUESTTYPEFIELD.has_default_value = false
var_0_1.READMAILBATCHREQUESTTYPEFIELD.default_value = 0
var_0_1.READMAILBATCHREQUESTTYPEFIELD.type = 13
var_0_1.READMAILBATCHREQUESTTYPEFIELD.cpp_type = 3
var_0_1.READMAILBATCHREQUEST_MSG.name = "ReadMailBatchRequest"
var_0_1.READMAILBATCHREQUEST_MSG.full_name = ".ReadMailBatchRequest"
var_0_1.READMAILBATCHREQUEST_MSG.nested_types = {}
var_0_1.READMAILBATCHREQUEST_MSG.enum_types = {}
var_0_1.READMAILBATCHREQUEST_MSG.fields = {
	var_0_1.READMAILBATCHREQUESTTYPEFIELD
}
var_0_1.READMAILBATCHREQUEST_MSG.is_extendable = false
var_0_1.READMAILBATCHREQUEST_MSG.extensions = {}
var_0_1.DELETEMAILBATCHREQUESTTYPEFIELD.name = "type"
var_0_1.DELETEMAILBATCHREQUESTTYPEFIELD.full_name = ".DeleteMailBatchRequest.type"
var_0_1.DELETEMAILBATCHREQUESTTYPEFIELD.number = 1
var_0_1.DELETEMAILBATCHREQUESTTYPEFIELD.index = 0
var_0_1.DELETEMAILBATCHREQUESTTYPEFIELD.label = 1
var_0_1.DELETEMAILBATCHREQUESTTYPEFIELD.has_default_value = false
var_0_1.DELETEMAILBATCHREQUESTTYPEFIELD.default_value = 0
var_0_1.DELETEMAILBATCHREQUESTTYPEFIELD.type = 13
var_0_1.DELETEMAILBATCHREQUESTTYPEFIELD.cpp_type = 3
var_0_1.DELETEMAILBATCHREQUEST_MSG.name = "DeleteMailBatchRequest"
var_0_1.DELETEMAILBATCHREQUEST_MSG.full_name = ".DeleteMailBatchRequest"
var_0_1.DELETEMAILBATCHREQUEST_MSG.nested_types = {}
var_0_1.DELETEMAILBATCHREQUEST_MSG.enum_types = {}
var_0_1.DELETEMAILBATCHREQUEST_MSG.fields = {
	var_0_1.DELETEMAILBATCHREQUESTTYPEFIELD
}
var_0_1.DELETEMAILBATCHREQUEST_MSG.is_extendable = false
var_0_1.DELETEMAILBATCHREQUEST_MSG.extensions = {}
var_0_1.READMAILREPLYINCRIDFIELD.name = "incrId"
var_0_1.READMAILREPLYINCRIDFIELD.full_name = ".ReadMailReply.incrId"
var_0_1.READMAILREPLYINCRIDFIELD.number = 1
var_0_1.READMAILREPLYINCRIDFIELD.index = 0
var_0_1.READMAILREPLYINCRIDFIELD.label = 1
var_0_1.READMAILREPLYINCRIDFIELD.has_default_value = false
var_0_1.READMAILREPLYINCRIDFIELD.default_value = 0
var_0_1.READMAILREPLYINCRIDFIELD.type = 4
var_0_1.READMAILREPLYINCRIDFIELD.cpp_type = 4
var_0_1.READMAILREPLY_MSG.name = "ReadMailReply"
var_0_1.READMAILREPLY_MSG.full_name = ".ReadMailReply"
var_0_1.READMAILREPLY_MSG.nested_types = {}
var_0_1.READMAILREPLY_MSG.enum_types = {}
var_0_1.READMAILREPLY_MSG.fields = {
	var_0_1.READMAILREPLYINCRIDFIELD
}
var_0_1.READMAILREPLY_MSG.is_extendable = false
var_0_1.READMAILREPLY_MSG.extensions = {}
var_0_1.MARKMAILJUMPREQUESTINCRIDFIELD.name = "incrId"
var_0_1.MARKMAILJUMPREQUESTINCRIDFIELD.full_name = ".MarkMailJumpRequest.incrId"
var_0_1.MARKMAILJUMPREQUESTINCRIDFIELD.number = 1
var_0_1.MARKMAILJUMPREQUESTINCRIDFIELD.index = 0
var_0_1.MARKMAILJUMPREQUESTINCRIDFIELD.label = 1
var_0_1.MARKMAILJUMPREQUESTINCRIDFIELD.has_default_value = false
var_0_1.MARKMAILJUMPREQUESTINCRIDFIELD.default_value = 0
var_0_1.MARKMAILJUMPREQUESTINCRIDFIELD.type = 4
var_0_1.MARKMAILJUMPREQUESTINCRIDFIELD.cpp_type = 4
var_0_1.MARKMAILJUMPREQUEST_MSG.name = "MarkMailJumpRequest"
var_0_1.MARKMAILJUMPREQUEST_MSG.full_name = ".MarkMailJumpRequest"
var_0_1.MARKMAILJUMPREQUEST_MSG.nested_types = {}
var_0_1.MARKMAILJUMPREQUEST_MSG.enum_types = {}
var_0_1.MARKMAILJUMPREQUEST_MSG.fields = {
	var_0_1.MARKMAILJUMPREQUESTINCRIDFIELD
}
var_0_1.MARKMAILJUMPREQUEST_MSG.is_extendable = false
var_0_1.MARKMAILJUMPREQUEST_MSG.extensions = {}
var_0_1.DELETEMAILBATCHREPLYINCRIDSFIELD.name = "incrIds"
var_0_1.DELETEMAILBATCHREPLYINCRIDSFIELD.full_name = ".DeleteMailBatchReply.incrIds"
var_0_1.DELETEMAILBATCHREPLYINCRIDSFIELD.number = 1
var_0_1.DELETEMAILBATCHREPLYINCRIDSFIELD.index = 0
var_0_1.DELETEMAILBATCHREPLYINCRIDSFIELD.label = 3
var_0_1.DELETEMAILBATCHREPLYINCRIDSFIELD.has_default_value = false
var_0_1.DELETEMAILBATCHREPLYINCRIDSFIELD.default_value = {}
var_0_1.DELETEMAILBATCHREPLYINCRIDSFIELD.type = 4
var_0_1.DELETEMAILBATCHREPLYINCRIDSFIELD.cpp_type = 4
var_0_1.DELETEMAILBATCHREPLY_MSG.name = "DeleteMailBatchReply"
var_0_1.DELETEMAILBATCHREPLY_MSG.full_name = ".DeleteMailBatchReply"
var_0_1.DELETEMAILBATCHREPLY_MSG.nested_types = {}
var_0_1.DELETEMAILBATCHREPLY_MSG.enum_types = {}
var_0_1.DELETEMAILBATCHREPLY_MSG.fields = {
	var_0_1.DELETEMAILBATCHREPLYINCRIDSFIELD
}
var_0_1.DELETEMAILBATCHREPLY_MSG.is_extendable = false
var_0_1.DELETEMAILBATCHREPLY_MSG.extensions = {}
var_0_1.MARKMAILJUMPREPLYINCRIDFIELD.name = "incrId"
var_0_1.MARKMAILJUMPREPLYINCRIDFIELD.full_name = ".MarkMailJumpReply.incrId"
var_0_1.MARKMAILJUMPREPLYINCRIDFIELD.number = 1
var_0_1.MARKMAILJUMPREPLYINCRIDFIELD.index = 0
var_0_1.MARKMAILJUMPREPLYINCRIDFIELD.label = 1
var_0_1.MARKMAILJUMPREPLYINCRIDFIELD.has_default_value = false
var_0_1.MARKMAILJUMPREPLYINCRIDFIELD.default_value = 0
var_0_1.MARKMAILJUMPREPLYINCRIDFIELD.type = 4
var_0_1.MARKMAILJUMPREPLYINCRIDFIELD.cpp_type = 4
var_0_1.MARKMAILJUMPREPLY_MSG.name = "MarkMailJumpReply"
var_0_1.MARKMAILJUMPREPLY_MSG.full_name = ".MarkMailJumpReply"
var_0_1.MARKMAILJUMPREPLY_MSG.nested_types = {}
var_0_1.MARKMAILJUMPREPLY_MSG.enum_types = {}
var_0_1.MARKMAILJUMPREPLY_MSG.fields = {
	var_0_1.MARKMAILJUMPREPLYINCRIDFIELD
}
var_0_1.MARKMAILJUMPREPLY_MSG.is_extendable = false
var_0_1.MARKMAILJUMPREPLY_MSG.extensions = {}
var_0_1.READMAILREQUESTINCRIDFIELD.name = "incrId"
var_0_1.READMAILREQUESTINCRIDFIELD.full_name = ".ReadMailRequest.incrId"
var_0_1.READMAILREQUESTINCRIDFIELD.number = 1
var_0_1.READMAILREQUESTINCRIDFIELD.index = 0
var_0_1.READMAILREQUESTINCRIDFIELD.label = 1
var_0_1.READMAILREQUESTINCRIDFIELD.has_default_value = false
var_0_1.READMAILREQUESTINCRIDFIELD.default_value = 0
var_0_1.READMAILREQUESTINCRIDFIELD.type = 4
var_0_1.READMAILREQUESTINCRIDFIELD.cpp_type = 4
var_0_1.READMAILREQUEST_MSG.name = "ReadMailRequest"
var_0_1.READMAILREQUEST_MSG.full_name = ".ReadMailRequest"
var_0_1.READMAILREQUEST_MSG.nested_types = {}
var_0_1.READMAILREQUEST_MSG.enum_types = {}
var_0_1.READMAILREQUEST_MSG.fields = {
	var_0_1.READMAILREQUESTINCRIDFIELD
}
var_0_1.READMAILREQUEST_MSG.is_extendable = false
var_0_1.READMAILREQUEST_MSG.extensions = {}
var_0_1.GETALLMAILSREPLYMAILSFIELD.name = "mails"
var_0_1.GETALLMAILSREPLYMAILSFIELD.full_name = ".GetAllMailsReply.mails"
var_0_1.GETALLMAILSREPLYMAILSFIELD.number = 1
var_0_1.GETALLMAILSREPLYMAILSFIELD.index = 0
var_0_1.GETALLMAILSREPLYMAILSFIELD.label = 3
var_0_1.GETALLMAILSREPLYMAILSFIELD.has_default_value = false
var_0_1.GETALLMAILSREPLYMAILSFIELD.default_value = {}
var_0_1.GETALLMAILSREPLYMAILSFIELD.message_type = var_0_1.MAIL_MSG
var_0_1.GETALLMAILSREPLYMAILSFIELD.type = 11
var_0_1.GETALLMAILSREPLYMAILSFIELD.cpp_type = 10
var_0_1.GETALLMAILSREPLY_MSG.name = "GetAllMailsReply"
var_0_1.GETALLMAILSREPLY_MSG.full_name = ".GetAllMailsReply"
var_0_1.GETALLMAILSREPLY_MSG.nested_types = {}
var_0_1.GETALLMAILSREPLY_MSG.enum_types = {}
var_0_1.GETALLMAILSREPLY_MSG.fields = {
	var_0_1.GETALLMAILSREPLYMAILSFIELD
}
var_0_1.GETALLMAILSREPLY_MSG.is_extendable = false
var_0_1.GETALLMAILSREPLY_MSG.extensions = {}
var_0_1.MAILINCRIDFIELD.name = "incrId"
var_0_1.MAILINCRIDFIELD.full_name = ".Mail.incrId"
var_0_1.MAILINCRIDFIELD.number = 1
var_0_1.MAILINCRIDFIELD.index = 0
var_0_1.MAILINCRIDFIELD.label = 1
var_0_1.MAILINCRIDFIELD.has_default_value = false
var_0_1.MAILINCRIDFIELD.default_value = 0
var_0_1.MAILINCRIDFIELD.type = 4
var_0_1.MAILINCRIDFIELD.cpp_type = 4
var_0_1.MAILMAILIDFIELD.name = "mailId"
var_0_1.MAILMAILIDFIELD.full_name = ".Mail.mailId"
var_0_1.MAILMAILIDFIELD.number = 2
var_0_1.MAILMAILIDFIELD.index = 1
var_0_1.MAILMAILIDFIELD.label = 1
var_0_1.MAILMAILIDFIELD.has_default_value = false
var_0_1.MAILMAILIDFIELD.default_value = 0
var_0_1.MAILMAILIDFIELD.type = 13
var_0_1.MAILMAILIDFIELD.cpp_type = 3
var_0_1.MAILPARAMSFIELD.name = "params"
var_0_1.MAILPARAMSFIELD.full_name = ".Mail.params"
var_0_1.MAILPARAMSFIELD.number = 3
var_0_1.MAILPARAMSFIELD.index = 2
var_0_1.MAILPARAMSFIELD.label = 1
var_0_1.MAILPARAMSFIELD.has_default_value = false
var_0_1.MAILPARAMSFIELD.default_value = ""
var_0_1.MAILPARAMSFIELD.type = 9
var_0_1.MAILPARAMSFIELD.cpp_type = 9
var_0_1.MAILATTACHMENTFIELD.name = "attachment"
var_0_1.MAILATTACHMENTFIELD.full_name = ".Mail.attachment"
var_0_1.MAILATTACHMENTFIELD.number = 4
var_0_1.MAILATTACHMENTFIELD.index = 3
var_0_1.MAILATTACHMENTFIELD.label = 1
var_0_1.MAILATTACHMENTFIELD.has_default_value = false
var_0_1.MAILATTACHMENTFIELD.default_value = ""
var_0_1.MAILATTACHMENTFIELD.type = 9
var_0_1.MAILATTACHMENTFIELD.cpp_type = 9
var_0_1.MAILSTATEFIELD.name = "state"
var_0_1.MAILSTATEFIELD.full_name = ".Mail.state"
var_0_1.MAILSTATEFIELD.number = 5
var_0_1.MAILSTATEFIELD.index = 4
var_0_1.MAILSTATEFIELD.label = 1
var_0_1.MAILSTATEFIELD.has_default_value = false
var_0_1.MAILSTATEFIELD.default_value = 0
var_0_1.MAILSTATEFIELD.type = 13
var_0_1.MAILSTATEFIELD.cpp_type = 3
var_0_1.MAILCREATETIMEFIELD.name = "createTime"
var_0_1.MAILCREATETIMEFIELD.full_name = ".Mail.createTime"
var_0_1.MAILCREATETIMEFIELD.number = 6
var_0_1.MAILCREATETIMEFIELD.index = 5
var_0_1.MAILCREATETIMEFIELD.label = 1
var_0_1.MAILCREATETIMEFIELD.has_default_value = false
var_0_1.MAILCREATETIMEFIELD.default_value = 0
var_0_1.MAILCREATETIMEFIELD.type = 4
var_0_1.MAILCREATETIMEFIELD.cpp_type = 4
var_0_1.MAILSENDERFIELD.name = "sender"
var_0_1.MAILSENDERFIELD.full_name = ".Mail.sender"
var_0_1.MAILSENDERFIELD.number = 7
var_0_1.MAILSENDERFIELD.index = 6
var_0_1.MAILSENDERFIELD.label = 1
var_0_1.MAILSENDERFIELD.has_default_value = false
var_0_1.MAILSENDERFIELD.default_value = ""
var_0_1.MAILSENDERFIELD.type = 9
var_0_1.MAILSENDERFIELD.cpp_type = 9
var_0_1.MAILTITLEFIELD.name = "title"
var_0_1.MAILTITLEFIELD.full_name = ".Mail.title"
var_0_1.MAILTITLEFIELD.number = 8
var_0_1.MAILTITLEFIELD.index = 7
var_0_1.MAILTITLEFIELD.label = 1
var_0_1.MAILTITLEFIELD.has_default_value = false
var_0_1.MAILTITLEFIELD.default_value = ""
var_0_1.MAILTITLEFIELD.type = 9
var_0_1.MAILTITLEFIELD.cpp_type = 9
var_0_1.MAILCONTENTFIELD.name = "content"
var_0_1.MAILCONTENTFIELD.full_name = ".Mail.content"
var_0_1.MAILCONTENTFIELD.number = 9
var_0_1.MAILCONTENTFIELD.index = 8
var_0_1.MAILCONTENTFIELD.label = 1
var_0_1.MAILCONTENTFIELD.has_default_value = false
var_0_1.MAILCONTENTFIELD.default_value = ""
var_0_1.MAILCONTENTFIELD.type = 9
var_0_1.MAILCONTENTFIELD.cpp_type = 9
var_0_1.MAILCOPYFIELD.name = "copy"
var_0_1.MAILCOPYFIELD.full_name = ".Mail.copy"
var_0_1.MAILCOPYFIELD.number = 10
var_0_1.MAILCOPYFIELD.index = 9
var_0_1.MAILCOPYFIELD.label = 1
var_0_1.MAILCOPYFIELD.has_default_value = false
var_0_1.MAILCOPYFIELD.default_value = ""
var_0_1.MAILCOPYFIELD.type = 9
var_0_1.MAILCOPYFIELD.cpp_type = 9
var_0_1.MAILEXPIRETIMEFIELD.name = "expireTime"
var_0_1.MAILEXPIRETIMEFIELD.full_name = ".Mail.expireTime"
var_0_1.MAILEXPIRETIMEFIELD.number = 11
var_0_1.MAILEXPIRETIMEFIELD.index = 10
var_0_1.MAILEXPIRETIMEFIELD.label = 1
var_0_1.MAILEXPIRETIMEFIELD.has_default_value = false
var_0_1.MAILEXPIRETIMEFIELD.default_value = 0
var_0_1.MAILEXPIRETIMEFIELD.type = 4
var_0_1.MAILEXPIRETIMEFIELD.cpp_type = 4
var_0_1.MAILSENDERTYPEFIELD.name = "senderType"
var_0_1.MAILSENDERTYPEFIELD.full_name = ".Mail.senderType"
var_0_1.MAILSENDERTYPEFIELD.number = 12
var_0_1.MAILSENDERTYPEFIELD.index = 11
var_0_1.MAILSENDERTYPEFIELD.label = 1
var_0_1.MAILSENDERTYPEFIELD.has_default_value = false
var_0_1.MAILSENDERTYPEFIELD.default_value = 0
var_0_1.MAILSENDERTYPEFIELD.type = 5
var_0_1.MAILSENDERTYPEFIELD.cpp_type = 1
var_0_1.MAILJUMPTITLEFIELD.name = "jumpTitle"
var_0_1.MAILJUMPTITLEFIELD.full_name = ".Mail.jumpTitle"
var_0_1.MAILJUMPTITLEFIELD.number = 13
var_0_1.MAILJUMPTITLEFIELD.index = 12
var_0_1.MAILJUMPTITLEFIELD.label = 1
var_0_1.MAILJUMPTITLEFIELD.has_default_value = false
var_0_1.MAILJUMPTITLEFIELD.default_value = ""
var_0_1.MAILJUMPTITLEFIELD.type = 9
var_0_1.MAILJUMPTITLEFIELD.cpp_type = 9
var_0_1.MAILJUMPFIELD.name = "jump"
var_0_1.MAILJUMPFIELD.full_name = ".Mail.jump"
var_0_1.MAILJUMPFIELD.number = 14
var_0_1.MAILJUMPFIELD.index = 13
var_0_1.MAILJUMPFIELD.label = 1
var_0_1.MAILJUMPFIELD.has_default_value = false
var_0_1.MAILJUMPFIELD.default_value = ""
var_0_1.MAILJUMPFIELD.type = 9
var_0_1.MAILJUMPFIELD.cpp_type = 9
var_0_1.MAIL_MSG.name = "Mail"
var_0_1.MAIL_MSG.full_name = ".Mail"
var_0_1.MAIL_MSG.nested_types = {}
var_0_1.MAIL_MSG.enum_types = {}
var_0_1.MAIL_MSG.fields = {
	var_0_1.MAILINCRIDFIELD,
	var_0_1.MAILMAILIDFIELD,
	var_0_1.MAILPARAMSFIELD,
	var_0_1.MAILATTACHMENTFIELD,
	var_0_1.MAILSTATEFIELD,
	var_0_1.MAILCREATETIMEFIELD,
	var_0_1.MAILSENDERFIELD,
	var_0_1.MAILTITLEFIELD,
	var_0_1.MAILCONTENTFIELD,
	var_0_1.MAILCOPYFIELD,
	var_0_1.MAILEXPIRETIMEFIELD,
	var_0_1.MAILSENDERTYPEFIELD,
	var_0_1.MAILJUMPTITLEFIELD,
	var_0_1.MAILJUMPFIELD
}
var_0_1.MAIL_MSG.is_extendable = false
var_0_1.MAIL_MSG.extensions = {}
var_0_1.DELETEMAILSPUSHINCRIDSFIELD.name = "incrIds"
var_0_1.DELETEMAILSPUSHINCRIDSFIELD.full_name = ".DeleteMailsPush.incrIds"
var_0_1.DELETEMAILSPUSHINCRIDSFIELD.number = 1
var_0_1.DELETEMAILSPUSHINCRIDSFIELD.index = 0
var_0_1.DELETEMAILSPUSHINCRIDSFIELD.label = 3
var_0_1.DELETEMAILSPUSHINCRIDSFIELD.has_default_value = false
var_0_1.DELETEMAILSPUSHINCRIDSFIELD.default_value = {}
var_0_1.DELETEMAILSPUSHINCRIDSFIELD.type = 4
var_0_1.DELETEMAILSPUSHINCRIDSFIELD.cpp_type = 4
var_0_1.DELETEMAILSPUSH_MSG.name = "DeleteMailsPush"
var_0_1.DELETEMAILSPUSH_MSG.full_name = ".DeleteMailsPush"
var_0_1.DELETEMAILSPUSH_MSG.nested_types = {}
var_0_1.DELETEMAILSPUSH_MSG.enum_types = {}
var_0_1.DELETEMAILSPUSH_MSG.fields = {
	var_0_1.DELETEMAILSPUSHINCRIDSFIELD
}
var_0_1.DELETEMAILSPUSH_MSG.is_extendable = false
var_0_1.DELETEMAILSPUSH_MSG.extensions = {}
var_0_1.GETALLMAILSREQUEST_MSG.name = "GetAllMailsRequest"
var_0_1.GETALLMAILSREQUEST_MSG.full_name = ".GetAllMailsRequest"
var_0_1.GETALLMAILSREQUEST_MSG.nested_types = {}
var_0_1.GETALLMAILSREQUEST_MSG.enum_types = {}
var_0_1.GETALLMAILSREQUEST_MSG.fields = {}
var_0_1.GETALLMAILSREQUEST_MSG.is_extendable = false
var_0_1.GETALLMAILSREQUEST_MSG.extensions = {}
var_0_1.AUTOREADMAILPUSHINCRIDSFIELD.name = "incrIds"
var_0_1.AUTOREADMAILPUSHINCRIDSFIELD.full_name = ".AutoReadMailPush.incrIds"
var_0_1.AUTOREADMAILPUSHINCRIDSFIELD.number = 1
var_0_1.AUTOREADMAILPUSHINCRIDSFIELD.index = 0
var_0_1.AUTOREADMAILPUSHINCRIDSFIELD.label = 3
var_0_1.AUTOREADMAILPUSHINCRIDSFIELD.has_default_value = false
var_0_1.AUTOREADMAILPUSHINCRIDSFIELD.default_value = {}
var_0_1.AUTOREADMAILPUSHINCRIDSFIELD.type = 4
var_0_1.AUTOREADMAILPUSHINCRIDSFIELD.cpp_type = 4
var_0_1.AUTOREADMAILPUSH_MSG.name = "AutoReadMailPush"
var_0_1.AUTOREADMAILPUSH_MSG.full_name = ".AutoReadMailPush"
var_0_1.AUTOREADMAILPUSH_MSG.nested_types = {}
var_0_1.AUTOREADMAILPUSH_MSG.enum_types = {}
var_0_1.AUTOREADMAILPUSH_MSG.fields = {
	var_0_1.AUTOREADMAILPUSHINCRIDSFIELD
}
var_0_1.AUTOREADMAILPUSH_MSG.is_extendable = false
var_0_1.AUTOREADMAILPUSH_MSG.extensions = {}
var_0_1.READMAILBATCHREPLYINCRIDSFIELD.name = "incrIds"
var_0_1.READMAILBATCHREPLYINCRIDSFIELD.full_name = ".ReadMailBatchReply.incrIds"
var_0_1.READMAILBATCHREPLYINCRIDSFIELD.number = 1
var_0_1.READMAILBATCHREPLYINCRIDSFIELD.index = 0
var_0_1.READMAILBATCHREPLYINCRIDSFIELD.label = 3
var_0_1.READMAILBATCHREPLYINCRIDSFIELD.has_default_value = false
var_0_1.READMAILBATCHREPLYINCRIDSFIELD.default_value = {}
var_0_1.READMAILBATCHREPLYINCRIDSFIELD.type = 4
var_0_1.READMAILBATCHREPLYINCRIDSFIELD.cpp_type = 4
var_0_1.READMAILBATCHREPLY_MSG.name = "ReadMailBatchReply"
var_0_1.READMAILBATCHREPLY_MSG.full_name = ".ReadMailBatchReply"
var_0_1.READMAILBATCHREPLY_MSG.nested_types = {}
var_0_1.READMAILBATCHREPLY_MSG.enum_types = {}
var_0_1.READMAILBATCHREPLY_MSG.fields = {
	var_0_1.READMAILBATCHREPLYINCRIDSFIELD
}
var_0_1.READMAILBATCHREPLY_MSG.is_extendable = false
var_0_1.READMAILBATCHREPLY_MSG.extensions = {}
var_0_1.AutoReadMailPush = var_0_0.Message(var_0_1.AUTOREADMAILPUSH_MSG)
var_0_1.DeleteMailBatchReply = var_0_0.Message(var_0_1.DELETEMAILBATCHREPLY_MSG)
var_0_1.DeleteMailBatchRequest = var_0_0.Message(var_0_1.DELETEMAILBATCHREQUEST_MSG)
var_0_1.DeleteMailsPush = var_0_0.Message(var_0_1.DELETEMAILSPUSH_MSG)
var_0_1.GetAllMailsReply = var_0_0.Message(var_0_1.GETALLMAILSREPLY_MSG)
var_0_1.GetAllMailsRequest = var_0_0.Message(var_0_1.GETALLMAILSREQUEST_MSG)
var_0_1.Mail = var_0_0.Message(var_0_1.MAIL_MSG)
var_0_1.MarkMailJumpReply = var_0_0.Message(var_0_1.MARKMAILJUMPREPLY_MSG)
var_0_1.MarkMailJumpRequest = var_0_0.Message(var_0_1.MARKMAILJUMPREQUEST_MSG)
var_0_1.NewMailPush = var_0_0.Message(var_0_1.NEWMAILPUSH_MSG)
var_0_1.ReadMailBatchReply = var_0_0.Message(var_0_1.READMAILBATCHREPLY_MSG)
var_0_1.ReadMailBatchRequest = var_0_0.Message(var_0_1.READMAILBATCHREQUEST_MSG)
var_0_1.ReadMailReply = var_0_0.Message(var_0_1.READMAILREPLY_MSG)
var_0_1.ReadMailRequest = var_0_0.Message(var_0_1.READMAILREQUEST_MSG)

return var_0_1
