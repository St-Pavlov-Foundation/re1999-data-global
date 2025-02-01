slot1 = require("protobuf.protobuf")

module("modules.proto.MailModule_pb", package.seeall)

slot2 = {
	NEWMAILPUSH_MSG = slot1.Descriptor(),
	NEWMAILPUSHMAILFIELD = slot1.FieldDescriptor(),
	READMAILBATCHREQUEST_MSG = slot1.Descriptor(),
	READMAILBATCHREQUESTTYPEFIELD = slot1.FieldDescriptor(),
	DELETEMAILBATCHREQUEST_MSG = slot1.Descriptor(),
	DELETEMAILBATCHREQUESTTYPEFIELD = slot1.FieldDescriptor(),
	READMAILREPLY_MSG = slot1.Descriptor(),
	READMAILREPLYINCRIDFIELD = slot1.FieldDescriptor(),
	MARKMAILJUMPREQUEST_MSG = slot1.Descriptor(),
	MARKMAILJUMPREQUESTINCRIDFIELD = slot1.FieldDescriptor(),
	DELETEMAILBATCHREPLY_MSG = slot1.Descriptor(),
	DELETEMAILBATCHREPLYINCRIDSFIELD = slot1.FieldDescriptor(),
	MARKMAILJUMPREPLY_MSG = slot1.Descriptor(),
	MARKMAILJUMPREPLYINCRIDFIELD = slot1.FieldDescriptor(),
	READMAILREQUEST_MSG = slot1.Descriptor(),
	READMAILREQUESTINCRIDFIELD = slot1.FieldDescriptor(),
	GETALLMAILSREPLY_MSG = slot1.Descriptor(),
	GETALLMAILSREPLYMAILSFIELD = slot1.FieldDescriptor(),
	MAIL_MSG = slot1.Descriptor(),
	MAILINCRIDFIELD = slot1.FieldDescriptor(),
	MAILMAILIDFIELD = slot1.FieldDescriptor(),
	MAILPARAMSFIELD = slot1.FieldDescriptor(),
	MAILATTACHMENTFIELD = slot1.FieldDescriptor(),
	MAILSTATEFIELD = slot1.FieldDescriptor(),
	MAILCREATETIMEFIELD = slot1.FieldDescriptor(),
	MAILSENDERFIELD = slot1.FieldDescriptor(),
	MAILTITLEFIELD = slot1.FieldDescriptor(),
	MAILCONTENTFIELD = slot1.FieldDescriptor(),
	MAILCOPYFIELD = slot1.FieldDescriptor(),
	MAILEXPIRETIMEFIELD = slot1.FieldDescriptor(),
	MAILSENDERTYPEFIELD = slot1.FieldDescriptor(),
	MAILJUMPTITLEFIELD = slot1.FieldDescriptor(),
	MAILJUMPFIELD = slot1.FieldDescriptor(),
	DELETEMAILSPUSH_MSG = slot1.Descriptor(),
	DELETEMAILSPUSHINCRIDSFIELD = slot1.FieldDescriptor(),
	GETALLMAILSREQUEST_MSG = slot1.Descriptor(),
	AUTOREADMAILPUSH_MSG = slot1.Descriptor(),
	AUTOREADMAILPUSHINCRIDSFIELD = slot1.FieldDescriptor(),
	READMAILBATCHREPLY_MSG = slot1.Descriptor(),
	READMAILBATCHREPLYINCRIDSFIELD = slot1.FieldDescriptor()
}
slot2.NEWMAILPUSHMAILFIELD.name = "mail"
slot2.NEWMAILPUSHMAILFIELD.full_name = ".NewMailPush.mail"
slot2.NEWMAILPUSHMAILFIELD.number = 1
slot2.NEWMAILPUSHMAILFIELD.index = 0
slot2.NEWMAILPUSHMAILFIELD.label = 1
slot2.NEWMAILPUSHMAILFIELD.has_default_value = false
slot2.NEWMAILPUSHMAILFIELD.default_value = nil
slot2.NEWMAILPUSHMAILFIELD.message_type = slot2.MAIL_MSG
slot2.NEWMAILPUSHMAILFIELD.type = 11
slot2.NEWMAILPUSHMAILFIELD.cpp_type = 10
slot2.NEWMAILPUSH_MSG.name = "NewMailPush"
slot2.NEWMAILPUSH_MSG.full_name = ".NewMailPush"
slot2.NEWMAILPUSH_MSG.nested_types = {}
slot2.NEWMAILPUSH_MSG.enum_types = {}
slot2.NEWMAILPUSH_MSG.fields = {
	slot2.NEWMAILPUSHMAILFIELD
}
slot2.NEWMAILPUSH_MSG.is_extendable = false
slot2.NEWMAILPUSH_MSG.extensions = {}
slot2.READMAILBATCHREQUESTTYPEFIELD.name = "type"
slot2.READMAILBATCHREQUESTTYPEFIELD.full_name = ".ReadMailBatchRequest.type"
slot2.READMAILBATCHREQUESTTYPEFIELD.number = 1
slot2.READMAILBATCHREQUESTTYPEFIELD.index = 0
slot2.READMAILBATCHREQUESTTYPEFIELD.label = 1
slot2.READMAILBATCHREQUESTTYPEFIELD.has_default_value = false
slot2.READMAILBATCHREQUESTTYPEFIELD.default_value = 0
slot2.READMAILBATCHREQUESTTYPEFIELD.type = 13
slot2.READMAILBATCHREQUESTTYPEFIELD.cpp_type = 3
slot2.READMAILBATCHREQUEST_MSG.name = "ReadMailBatchRequest"
slot2.READMAILBATCHREQUEST_MSG.full_name = ".ReadMailBatchRequest"
slot2.READMAILBATCHREQUEST_MSG.nested_types = {}
slot2.READMAILBATCHREQUEST_MSG.enum_types = {}
slot2.READMAILBATCHREQUEST_MSG.fields = {
	slot2.READMAILBATCHREQUESTTYPEFIELD
}
slot2.READMAILBATCHREQUEST_MSG.is_extendable = false
slot2.READMAILBATCHREQUEST_MSG.extensions = {}
slot2.DELETEMAILBATCHREQUESTTYPEFIELD.name = "type"
slot2.DELETEMAILBATCHREQUESTTYPEFIELD.full_name = ".DeleteMailBatchRequest.type"
slot2.DELETEMAILBATCHREQUESTTYPEFIELD.number = 1
slot2.DELETEMAILBATCHREQUESTTYPEFIELD.index = 0
slot2.DELETEMAILBATCHREQUESTTYPEFIELD.label = 1
slot2.DELETEMAILBATCHREQUESTTYPEFIELD.has_default_value = false
slot2.DELETEMAILBATCHREQUESTTYPEFIELD.default_value = 0
slot2.DELETEMAILBATCHREQUESTTYPEFIELD.type = 13
slot2.DELETEMAILBATCHREQUESTTYPEFIELD.cpp_type = 3
slot2.DELETEMAILBATCHREQUEST_MSG.name = "DeleteMailBatchRequest"
slot2.DELETEMAILBATCHREQUEST_MSG.full_name = ".DeleteMailBatchRequest"
slot2.DELETEMAILBATCHREQUEST_MSG.nested_types = {}
slot2.DELETEMAILBATCHREQUEST_MSG.enum_types = {}
slot2.DELETEMAILBATCHREQUEST_MSG.fields = {
	slot2.DELETEMAILBATCHREQUESTTYPEFIELD
}
slot2.DELETEMAILBATCHREQUEST_MSG.is_extendable = false
slot2.DELETEMAILBATCHREQUEST_MSG.extensions = {}
slot2.READMAILREPLYINCRIDFIELD.name = "incrId"
slot2.READMAILREPLYINCRIDFIELD.full_name = ".ReadMailReply.incrId"
slot2.READMAILREPLYINCRIDFIELD.number = 1
slot2.READMAILREPLYINCRIDFIELD.index = 0
slot2.READMAILREPLYINCRIDFIELD.label = 1
slot2.READMAILREPLYINCRIDFIELD.has_default_value = false
slot2.READMAILREPLYINCRIDFIELD.default_value = 0
slot2.READMAILREPLYINCRIDFIELD.type = 4
slot2.READMAILREPLYINCRIDFIELD.cpp_type = 4
slot2.READMAILREPLY_MSG.name = "ReadMailReply"
slot2.READMAILREPLY_MSG.full_name = ".ReadMailReply"
slot2.READMAILREPLY_MSG.nested_types = {}
slot2.READMAILREPLY_MSG.enum_types = {}
slot2.READMAILREPLY_MSG.fields = {
	slot2.READMAILREPLYINCRIDFIELD
}
slot2.READMAILREPLY_MSG.is_extendable = false
slot2.READMAILREPLY_MSG.extensions = {}
slot2.MARKMAILJUMPREQUESTINCRIDFIELD.name = "incrId"
slot2.MARKMAILJUMPREQUESTINCRIDFIELD.full_name = ".MarkMailJumpRequest.incrId"
slot2.MARKMAILJUMPREQUESTINCRIDFIELD.number = 1
slot2.MARKMAILJUMPREQUESTINCRIDFIELD.index = 0
slot2.MARKMAILJUMPREQUESTINCRIDFIELD.label = 1
slot2.MARKMAILJUMPREQUESTINCRIDFIELD.has_default_value = false
slot2.MARKMAILJUMPREQUESTINCRIDFIELD.default_value = 0
slot2.MARKMAILJUMPREQUESTINCRIDFIELD.type = 4
slot2.MARKMAILJUMPREQUESTINCRIDFIELD.cpp_type = 4
slot2.MARKMAILJUMPREQUEST_MSG.name = "MarkMailJumpRequest"
slot2.MARKMAILJUMPREQUEST_MSG.full_name = ".MarkMailJumpRequest"
slot2.MARKMAILJUMPREQUEST_MSG.nested_types = {}
slot2.MARKMAILJUMPREQUEST_MSG.enum_types = {}
slot2.MARKMAILJUMPREQUEST_MSG.fields = {
	slot2.MARKMAILJUMPREQUESTINCRIDFIELD
}
slot2.MARKMAILJUMPREQUEST_MSG.is_extendable = false
slot2.MARKMAILJUMPREQUEST_MSG.extensions = {}
slot2.DELETEMAILBATCHREPLYINCRIDSFIELD.name = "incrIds"
slot2.DELETEMAILBATCHREPLYINCRIDSFIELD.full_name = ".DeleteMailBatchReply.incrIds"
slot2.DELETEMAILBATCHREPLYINCRIDSFIELD.number = 1
slot2.DELETEMAILBATCHREPLYINCRIDSFIELD.index = 0
slot2.DELETEMAILBATCHREPLYINCRIDSFIELD.label = 3
slot2.DELETEMAILBATCHREPLYINCRIDSFIELD.has_default_value = false
slot2.DELETEMAILBATCHREPLYINCRIDSFIELD.default_value = {}
slot2.DELETEMAILBATCHREPLYINCRIDSFIELD.type = 4
slot2.DELETEMAILBATCHREPLYINCRIDSFIELD.cpp_type = 4
slot2.DELETEMAILBATCHREPLY_MSG.name = "DeleteMailBatchReply"
slot2.DELETEMAILBATCHREPLY_MSG.full_name = ".DeleteMailBatchReply"
slot2.DELETEMAILBATCHREPLY_MSG.nested_types = {}
slot2.DELETEMAILBATCHREPLY_MSG.enum_types = {}
slot2.DELETEMAILBATCHREPLY_MSG.fields = {
	slot2.DELETEMAILBATCHREPLYINCRIDSFIELD
}
slot2.DELETEMAILBATCHREPLY_MSG.is_extendable = false
slot2.DELETEMAILBATCHREPLY_MSG.extensions = {}
slot2.MARKMAILJUMPREPLYINCRIDFIELD.name = "incrId"
slot2.MARKMAILJUMPREPLYINCRIDFIELD.full_name = ".MarkMailJumpReply.incrId"
slot2.MARKMAILJUMPREPLYINCRIDFIELD.number = 1
slot2.MARKMAILJUMPREPLYINCRIDFIELD.index = 0
slot2.MARKMAILJUMPREPLYINCRIDFIELD.label = 1
slot2.MARKMAILJUMPREPLYINCRIDFIELD.has_default_value = false
slot2.MARKMAILJUMPREPLYINCRIDFIELD.default_value = 0
slot2.MARKMAILJUMPREPLYINCRIDFIELD.type = 4
slot2.MARKMAILJUMPREPLYINCRIDFIELD.cpp_type = 4
slot2.MARKMAILJUMPREPLY_MSG.name = "MarkMailJumpReply"
slot2.MARKMAILJUMPREPLY_MSG.full_name = ".MarkMailJumpReply"
slot2.MARKMAILJUMPREPLY_MSG.nested_types = {}
slot2.MARKMAILJUMPREPLY_MSG.enum_types = {}
slot2.MARKMAILJUMPREPLY_MSG.fields = {
	slot2.MARKMAILJUMPREPLYINCRIDFIELD
}
slot2.MARKMAILJUMPREPLY_MSG.is_extendable = false
slot2.MARKMAILJUMPREPLY_MSG.extensions = {}
slot2.READMAILREQUESTINCRIDFIELD.name = "incrId"
slot2.READMAILREQUESTINCRIDFIELD.full_name = ".ReadMailRequest.incrId"
slot2.READMAILREQUESTINCRIDFIELD.number = 1
slot2.READMAILREQUESTINCRIDFIELD.index = 0
slot2.READMAILREQUESTINCRIDFIELD.label = 1
slot2.READMAILREQUESTINCRIDFIELD.has_default_value = false
slot2.READMAILREQUESTINCRIDFIELD.default_value = 0
slot2.READMAILREQUESTINCRIDFIELD.type = 4
slot2.READMAILREQUESTINCRIDFIELD.cpp_type = 4
slot2.READMAILREQUEST_MSG.name = "ReadMailRequest"
slot2.READMAILREQUEST_MSG.full_name = ".ReadMailRequest"
slot2.READMAILREQUEST_MSG.nested_types = {}
slot2.READMAILREQUEST_MSG.enum_types = {}
slot2.READMAILREQUEST_MSG.fields = {
	slot2.READMAILREQUESTINCRIDFIELD
}
slot2.READMAILREQUEST_MSG.is_extendable = false
slot2.READMAILREQUEST_MSG.extensions = {}
slot2.GETALLMAILSREPLYMAILSFIELD.name = "mails"
slot2.GETALLMAILSREPLYMAILSFIELD.full_name = ".GetAllMailsReply.mails"
slot2.GETALLMAILSREPLYMAILSFIELD.number = 1
slot2.GETALLMAILSREPLYMAILSFIELD.index = 0
slot2.GETALLMAILSREPLYMAILSFIELD.label = 3
slot2.GETALLMAILSREPLYMAILSFIELD.has_default_value = false
slot2.GETALLMAILSREPLYMAILSFIELD.default_value = {}
slot2.GETALLMAILSREPLYMAILSFIELD.message_type = slot2.MAIL_MSG
slot2.GETALLMAILSREPLYMAILSFIELD.type = 11
slot2.GETALLMAILSREPLYMAILSFIELD.cpp_type = 10
slot2.GETALLMAILSREPLY_MSG.name = "GetAllMailsReply"
slot2.GETALLMAILSREPLY_MSG.full_name = ".GetAllMailsReply"
slot2.GETALLMAILSREPLY_MSG.nested_types = {}
slot2.GETALLMAILSREPLY_MSG.enum_types = {}
slot2.GETALLMAILSREPLY_MSG.fields = {
	slot2.GETALLMAILSREPLYMAILSFIELD
}
slot2.GETALLMAILSREPLY_MSG.is_extendable = false
slot2.GETALLMAILSREPLY_MSG.extensions = {}
slot2.MAILINCRIDFIELD.name = "incrId"
slot2.MAILINCRIDFIELD.full_name = ".Mail.incrId"
slot2.MAILINCRIDFIELD.number = 1
slot2.MAILINCRIDFIELD.index = 0
slot2.MAILINCRIDFIELD.label = 1
slot2.MAILINCRIDFIELD.has_default_value = false
slot2.MAILINCRIDFIELD.default_value = 0
slot2.MAILINCRIDFIELD.type = 4
slot2.MAILINCRIDFIELD.cpp_type = 4
slot2.MAILMAILIDFIELD.name = "mailId"
slot2.MAILMAILIDFIELD.full_name = ".Mail.mailId"
slot2.MAILMAILIDFIELD.number = 2
slot2.MAILMAILIDFIELD.index = 1
slot2.MAILMAILIDFIELD.label = 1
slot2.MAILMAILIDFIELD.has_default_value = false
slot2.MAILMAILIDFIELD.default_value = 0
slot2.MAILMAILIDFIELD.type = 13
slot2.MAILMAILIDFIELD.cpp_type = 3
slot2.MAILPARAMSFIELD.name = "params"
slot2.MAILPARAMSFIELD.full_name = ".Mail.params"
slot2.MAILPARAMSFIELD.number = 3
slot2.MAILPARAMSFIELD.index = 2
slot2.MAILPARAMSFIELD.label = 1
slot2.MAILPARAMSFIELD.has_default_value = false
slot2.MAILPARAMSFIELD.default_value = ""
slot2.MAILPARAMSFIELD.type = 9
slot2.MAILPARAMSFIELD.cpp_type = 9
slot2.MAILATTACHMENTFIELD.name = "attachment"
slot2.MAILATTACHMENTFIELD.full_name = ".Mail.attachment"
slot2.MAILATTACHMENTFIELD.number = 4
slot2.MAILATTACHMENTFIELD.index = 3
slot2.MAILATTACHMENTFIELD.label = 1
slot2.MAILATTACHMENTFIELD.has_default_value = false
slot2.MAILATTACHMENTFIELD.default_value = ""
slot2.MAILATTACHMENTFIELD.type = 9
slot2.MAILATTACHMENTFIELD.cpp_type = 9
slot2.MAILSTATEFIELD.name = "state"
slot2.MAILSTATEFIELD.full_name = ".Mail.state"
slot2.MAILSTATEFIELD.number = 5
slot2.MAILSTATEFIELD.index = 4
slot2.MAILSTATEFIELD.label = 1
slot2.MAILSTATEFIELD.has_default_value = false
slot2.MAILSTATEFIELD.default_value = 0
slot2.MAILSTATEFIELD.type = 13
slot2.MAILSTATEFIELD.cpp_type = 3
slot2.MAILCREATETIMEFIELD.name = "createTime"
slot2.MAILCREATETIMEFIELD.full_name = ".Mail.createTime"
slot2.MAILCREATETIMEFIELD.number = 6
slot2.MAILCREATETIMEFIELD.index = 5
slot2.MAILCREATETIMEFIELD.label = 1
slot2.MAILCREATETIMEFIELD.has_default_value = false
slot2.MAILCREATETIMEFIELD.default_value = 0
slot2.MAILCREATETIMEFIELD.type = 4
slot2.MAILCREATETIMEFIELD.cpp_type = 4
slot2.MAILSENDERFIELD.name = "sender"
slot2.MAILSENDERFIELD.full_name = ".Mail.sender"
slot2.MAILSENDERFIELD.number = 7
slot2.MAILSENDERFIELD.index = 6
slot2.MAILSENDERFIELD.label = 1
slot2.MAILSENDERFIELD.has_default_value = false
slot2.MAILSENDERFIELD.default_value = ""
slot2.MAILSENDERFIELD.type = 9
slot2.MAILSENDERFIELD.cpp_type = 9
slot2.MAILTITLEFIELD.name = "title"
slot2.MAILTITLEFIELD.full_name = ".Mail.title"
slot2.MAILTITLEFIELD.number = 8
slot2.MAILTITLEFIELD.index = 7
slot2.MAILTITLEFIELD.label = 1
slot2.MAILTITLEFIELD.has_default_value = false
slot2.MAILTITLEFIELD.default_value = ""
slot2.MAILTITLEFIELD.type = 9
slot2.MAILTITLEFIELD.cpp_type = 9
slot2.MAILCONTENTFIELD.name = "content"
slot2.MAILCONTENTFIELD.full_name = ".Mail.content"
slot2.MAILCONTENTFIELD.number = 9
slot2.MAILCONTENTFIELD.index = 8
slot2.MAILCONTENTFIELD.label = 1
slot2.MAILCONTENTFIELD.has_default_value = false
slot2.MAILCONTENTFIELD.default_value = ""
slot2.MAILCONTENTFIELD.type = 9
slot2.MAILCONTENTFIELD.cpp_type = 9
slot2.MAILCOPYFIELD.name = "copy"
slot2.MAILCOPYFIELD.full_name = ".Mail.copy"
slot2.MAILCOPYFIELD.number = 10
slot2.MAILCOPYFIELD.index = 9
slot2.MAILCOPYFIELD.label = 1
slot2.MAILCOPYFIELD.has_default_value = false
slot2.MAILCOPYFIELD.default_value = ""
slot2.MAILCOPYFIELD.type = 9
slot2.MAILCOPYFIELD.cpp_type = 9
slot2.MAILEXPIRETIMEFIELD.name = "expireTime"
slot2.MAILEXPIRETIMEFIELD.full_name = ".Mail.expireTime"
slot2.MAILEXPIRETIMEFIELD.number = 11
slot2.MAILEXPIRETIMEFIELD.index = 10
slot2.MAILEXPIRETIMEFIELD.label = 1
slot2.MAILEXPIRETIMEFIELD.has_default_value = false
slot2.MAILEXPIRETIMEFIELD.default_value = 0
slot2.MAILEXPIRETIMEFIELD.type = 4
slot2.MAILEXPIRETIMEFIELD.cpp_type = 4
slot2.MAILSENDERTYPEFIELD.name = "senderType"
slot2.MAILSENDERTYPEFIELD.full_name = ".Mail.senderType"
slot2.MAILSENDERTYPEFIELD.number = 12
slot2.MAILSENDERTYPEFIELD.index = 11
slot2.MAILSENDERTYPEFIELD.label = 1
slot2.MAILSENDERTYPEFIELD.has_default_value = false
slot2.MAILSENDERTYPEFIELD.default_value = 0
slot2.MAILSENDERTYPEFIELD.type = 5
slot2.MAILSENDERTYPEFIELD.cpp_type = 1
slot2.MAILJUMPTITLEFIELD.name = "jumpTitle"
slot2.MAILJUMPTITLEFIELD.full_name = ".Mail.jumpTitle"
slot2.MAILJUMPTITLEFIELD.number = 13
slot2.MAILJUMPTITLEFIELD.index = 12
slot2.MAILJUMPTITLEFIELD.label = 1
slot2.MAILJUMPTITLEFIELD.has_default_value = false
slot2.MAILJUMPTITLEFIELD.default_value = ""
slot2.MAILJUMPTITLEFIELD.type = 9
slot2.MAILJUMPTITLEFIELD.cpp_type = 9
slot2.MAILJUMPFIELD.name = "jump"
slot2.MAILJUMPFIELD.full_name = ".Mail.jump"
slot2.MAILJUMPFIELD.number = 14
slot2.MAILJUMPFIELD.index = 13
slot2.MAILJUMPFIELD.label = 1
slot2.MAILJUMPFIELD.has_default_value = false
slot2.MAILJUMPFIELD.default_value = ""
slot2.MAILJUMPFIELD.type = 9
slot2.MAILJUMPFIELD.cpp_type = 9
slot2.MAIL_MSG.name = "Mail"
slot2.MAIL_MSG.full_name = ".Mail"
slot2.MAIL_MSG.nested_types = {}
slot2.MAIL_MSG.enum_types = {}
slot2.MAIL_MSG.fields = {
	slot2.MAILINCRIDFIELD,
	slot2.MAILMAILIDFIELD,
	slot2.MAILPARAMSFIELD,
	slot2.MAILATTACHMENTFIELD,
	slot2.MAILSTATEFIELD,
	slot2.MAILCREATETIMEFIELD,
	slot2.MAILSENDERFIELD,
	slot2.MAILTITLEFIELD,
	slot2.MAILCONTENTFIELD,
	slot2.MAILCOPYFIELD,
	slot2.MAILEXPIRETIMEFIELD,
	slot2.MAILSENDERTYPEFIELD,
	slot2.MAILJUMPTITLEFIELD,
	slot2.MAILJUMPFIELD
}
slot2.MAIL_MSG.is_extendable = false
slot2.MAIL_MSG.extensions = {}
slot2.DELETEMAILSPUSHINCRIDSFIELD.name = "incrIds"
slot2.DELETEMAILSPUSHINCRIDSFIELD.full_name = ".DeleteMailsPush.incrIds"
slot2.DELETEMAILSPUSHINCRIDSFIELD.number = 1
slot2.DELETEMAILSPUSHINCRIDSFIELD.index = 0
slot2.DELETEMAILSPUSHINCRIDSFIELD.label = 3
slot2.DELETEMAILSPUSHINCRIDSFIELD.has_default_value = false
slot2.DELETEMAILSPUSHINCRIDSFIELD.default_value = {}
slot2.DELETEMAILSPUSHINCRIDSFIELD.type = 4
slot2.DELETEMAILSPUSHINCRIDSFIELD.cpp_type = 4
slot2.DELETEMAILSPUSH_MSG.name = "DeleteMailsPush"
slot2.DELETEMAILSPUSH_MSG.full_name = ".DeleteMailsPush"
slot2.DELETEMAILSPUSH_MSG.nested_types = {}
slot2.DELETEMAILSPUSH_MSG.enum_types = {}
slot2.DELETEMAILSPUSH_MSG.fields = {
	slot2.DELETEMAILSPUSHINCRIDSFIELD
}
slot2.DELETEMAILSPUSH_MSG.is_extendable = false
slot2.DELETEMAILSPUSH_MSG.extensions = {}
slot2.GETALLMAILSREQUEST_MSG.name = "GetAllMailsRequest"
slot2.GETALLMAILSREQUEST_MSG.full_name = ".GetAllMailsRequest"
slot2.GETALLMAILSREQUEST_MSG.nested_types = {}
slot2.GETALLMAILSREQUEST_MSG.enum_types = {}
slot2.GETALLMAILSREQUEST_MSG.fields = {}
slot2.GETALLMAILSREQUEST_MSG.is_extendable = false
slot2.GETALLMAILSREQUEST_MSG.extensions = {}
slot2.AUTOREADMAILPUSHINCRIDSFIELD.name = "incrIds"
slot2.AUTOREADMAILPUSHINCRIDSFIELD.full_name = ".AutoReadMailPush.incrIds"
slot2.AUTOREADMAILPUSHINCRIDSFIELD.number = 1
slot2.AUTOREADMAILPUSHINCRIDSFIELD.index = 0
slot2.AUTOREADMAILPUSHINCRIDSFIELD.label = 3
slot2.AUTOREADMAILPUSHINCRIDSFIELD.has_default_value = false
slot2.AUTOREADMAILPUSHINCRIDSFIELD.default_value = {}
slot2.AUTOREADMAILPUSHINCRIDSFIELD.type = 4
slot2.AUTOREADMAILPUSHINCRIDSFIELD.cpp_type = 4
slot2.AUTOREADMAILPUSH_MSG.name = "AutoReadMailPush"
slot2.AUTOREADMAILPUSH_MSG.full_name = ".AutoReadMailPush"
slot2.AUTOREADMAILPUSH_MSG.nested_types = {}
slot2.AUTOREADMAILPUSH_MSG.enum_types = {}
slot2.AUTOREADMAILPUSH_MSG.fields = {
	slot2.AUTOREADMAILPUSHINCRIDSFIELD
}
slot2.AUTOREADMAILPUSH_MSG.is_extendable = false
slot2.AUTOREADMAILPUSH_MSG.extensions = {}
slot2.READMAILBATCHREPLYINCRIDSFIELD.name = "incrIds"
slot2.READMAILBATCHREPLYINCRIDSFIELD.full_name = ".ReadMailBatchReply.incrIds"
slot2.READMAILBATCHREPLYINCRIDSFIELD.number = 1
slot2.READMAILBATCHREPLYINCRIDSFIELD.index = 0
slot2.READMAILBATCHREPLYINCRIDSFIELD.label = 3
slot2.READMAILBATCHREPLYINCRIDSFIELD.has_default_value = false
slot2.READMAILBATCHREPLYINCRIDSFIELD.default_value = {}
slot2.READMAILBATCHREPLYINCRIDSFIELD.type = 4
slot2.READMAILBATCHREPLYINCRIDSFIELD.cpp_type = 4
slot2.READMAILBATCHREPLY_MSG.name = "ReadMailBatchReply"
slot2.READMAILBATCHREPLY_MSG.full_name = ".ReadMailBatchReply"
slot2.READMAILBATCHREPLY_MSG.nested_types = {}
slot2.READMAILBATCHREPLY_MSG.enum_types = {}
slot2.READMAILBATCHREPLY_MSG.fields = {
	slot2.READMAILBATCHREPLYINCRIDSFIELD
}
slot2.READMAILBATCHREPLY_MSG.is_extendable = false
slot2.READMAILBATCHREPLY_MSG.extensions = {}
slot2.AutoReadMailPush = slot1.Message(slot2.AUTOREADMAILPUSH_MSG)
slot2.DeleteMailBatchReply = slot1.Message(slot2.DELETEMAILBATCHREPLY_MSG)
slot2.DeleteMailBatchRequest = slot1.Message(slot2.DELETEMAILBATCHREQUEST_MSG)
slot2.DeleteMailsPush = slot1.Message(slot2.DELETEMAILSPUSH_MSG)
slot2.GetAllMailsReply = slot1.Message(slot2.GETALLMAILSREPLY_MSG)
slot2.GetAllMailsRequest = slot1.Message(slot2.GETALLMAILSREQUEST_MSG)
slot2.Mail = slot1.Message(slot2.MAIL_MSG)
slot2.MarkMailJumpReply = slot1.Message(slot2.MARKMAILJUMPREPLY_MSG)
slot2.MarkMailJumpRequest = slot1.Message(slot2.MARKMAILJUMPREQUEST_MSG)
slot2.NewMailPush = slot1.Message(slot2.NEWMAILPUSH_MSG)
slot2.ReadMailBatchReply = slot1.Message(slot2.READMAILBATCHREPLY_MSG)
slot2.ReadMailBatchRequest = slot1.Message(slot2.READMAILBATCHREQUEST_MSG)
slot2.ReadMailReply = slot1.Message(slot2.READMAILREPLY_MSG)
slot2.ReadMailRequest = slot1.Message(slot2.READMAILREQUEST_MSG)

return slot2
