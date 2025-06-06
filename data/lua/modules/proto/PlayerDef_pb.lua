﻿local var_0_0 = require
local var_0_1 = var_0_0("protobuf.protobuf")

module("modules.proto.PlayerDef_pb", package.seeall)

local var_0_2 = {
	HERODEF_PB = var_0_0("modules.proto.HeroDef_pb"),
	SIMPLEPLAYERINFO_MSG = var_0_1.Descriptor(),
	SIMPLEPLAYERINFOUSERIDFIELD = var_0_1.FieldDescriptor(),
	SIMPLEPLAYERINFONAMEFIELD = var_0_1.FieldDescriptor(),
	SIMPLEPLAYERINFOPORTRAITFIELD = var_0_1.FieldDescriptor(),
	SIMPLEPLAYERINFOLEVELFIELD = var_0_1.FieldDescriptor(),
	SIMPLEPLAYERINFOISONLINEFIELD = var_0_1.FieldDescriptor(),
	SIMPLEPLAYERINFOZONEIDFIELD = var_0_1.FieldDescriptor(),
	SIMPLEPLAYERINFODATETIMEFIELD = var_0_1.FieldDescriptor(),
	PLAYERCLOTH_MSG = var_0_1.Descriptor(),
	PLAYERCLOTHCLOTHIDFIELD = var_0_1.FieldDescriptor(),
	PLAYERCLOTHLEVELFIELD = var_0_1.FieldDescriptor(),
	PLAYERCLOTHEXPFIELD = var_0_1.FieldDescriptor(),
	PLAYERINFO_MSG = var_0_1.Descriptor(),
	PLAYERINFOUSERIDFIELD = var_0_1.FieldDescriptor(),
	PLAYERINFONAMEFIELD = var_0_1.FieldDescriptor(),
	PLAYERINFOPORTRAITFIELD = var_0_1.FieldDescriptor(),
	PLAYERINFOLEVELFIELD = var_0_1.FieldDescriptor(),
	PLAYERINFOEXPFIELD = var_0_1.FieldDescriptor(),
	PLAYERINFOSIGNATUREFIELD = var_0_1.FieldDescriptor(),
	PLAYERINFOBIRTHDAYFIELD = var_0_1.FieldDescriptor(),
	PLAYERINFOSHOWHEROSFIELD = var_0_1.FieldDescriptor(),
	PLAYERINFOREGISTERTIMEFIELD = var_0_1.FieldDescriptor(),
	PLAYERINFOHERORARENNCOUNTFIELD = var_0_1.FieldDescriptor(),
	PLAYERINFOHERORARENCOUNTFIELD = var_0_1.FieldDescriptor(),
	PLAYERINFOHERORARERCOUNTFIELD = var_0_1.FieldDescriptor(),
	PLAYERINFOHERORARESRCOUNTFIELD = var_0_1.FieldDescriptor(),
	PLAYERINFOHERORARESSRCOUNTFIELD = var_0_1.FieldDescriptor(),
	PLAYERINFOLASTEPISODEIDFIELD = var_0_1.FieldDescriptor(),
	PLAYERINFOLASTLOGINTIMEFIELD = var_0_1.FieldDescriptor(),
	PLAYERINFOLASTLOGOUTTIMEFIELD = var_0_1.FieldDescriptor(),
	PLAYERINFOCHARACTERAGEFIELD = var_0_1.FieldDescriptor(),
	PLAYERINFOSHOWACHIEVEMENTFIELD = var_0_1.FieldDescriptor(),
	PLAYERINFOBGFIELD = var_0_1.FieldDescriptor(),
	PLAYERINFOTOTALLOGINDAYSFIELD = var_0_1.FieldDescriptor(),
	PLAYERCLOTHINFO_MSG = var_0_1.Descriptor(),
	PLAYERCLOTHINFOCLOTHESFIELD = var_0_1.FieldDescriptor(),
	PLAYERCARDINFO_MSG = var_0_1.Descriptor(),
	PLAYERCARDINFOSHOWSETTINGSFIELD = var_0_1.FieldDescriptor(),
	PLAYERCARDINFOPROGRESSSETTINGFIELD = var_0_1.FieldDescriptor(),
	PLAYERCARDINFOBASESETTINGFIELD = var_0_1.FieldDescriptor(),
	PLAYERCARDINFOHEROCOVERFIELD = var_0_1.FieldDescriptor(),
	PLAYERCARDINFOTHEMEIDFIELD = var_0_1.FieldDescriptor(),
	PLAYERCARDINFOSHOWACHIEVEMENTFIELD = var_0_1.FieldDescriptor(),
	PLAYERCARDINFOCRITTERFIELD = var_0_1.FieldDescriptor(),
	PLAYERCARDINFOROOMCOLLECTIONFIELD = var_0_1.FieldDescriptor(),
	PLAYERCARDINFOWEEKWALKDEEPLAYERIDFIELD = var_0_1.FieldDescriptor(),
	PLAYERCARDINFOEXPLORECOLLECTIONFIELD = var_0_1.FieldDescriptor(),
	PLAYERCARDINFOROUGEDIFFICULTYFIELD = var_0_1.FieldDescriptor(),
	PLAYERCARDINFOACT128SSSCOUNTFIELD = var_0_1.FieldDescriptor(),
	PLAYERCARDINFOACHIEVEMENTCOUNTFIELD = var_0_1.FieldDescriptor(),
	PLAYERCARDINFOASSISTTIMESFIELD = var_0_1.FieldDescriptor(),
	PLAYERCARDINFOHEROCOVERTIMESFIELD = var_0_1.FieldDescriptor(),
	PLAYERCARDINFOMAXFAITHHEROCOUNTFIELD = var_0_1.FieldDescriptor(),
	PLAYERCARDINFOTOTALCOSTPOWERFIELD = var_0_1.FieldDescriptor(),
	PLAYERCARDINFOSKINCOUNTFIELD = var_0_1.FieldDescriptor(),
	PLAYERCARDINFOTOWERLAYERFIELD = var_0_1.FieldDescriptor(),
	PLAYERCARDINFOTOWERBOSSPASSCOUNTFIELD = var_0_1.FieldDescriptor(),
	PLAYERCARDINFOHEROMAXLEVELCOUNTFIELD = var_0_1.FieldDescriptor(),
	PLAYERCARDINFOWEEKWALKVER2PLATINUMCUPFIELD = var_0_1.FieldDescriptor()
}

var_0_2.SIMPLEPLAYERINFOUSERIDFIELD.name = "userId"
var_0_2.SIMPLEPLAYERINFOUSERIDFIELD.full_name = ".SimplePlayerInfo.userId"
var_0_2.SIMPLEPLAYERINFOUSERIDFIELD.number = 1
var_0_2.SIMPLEPLAYERINFOUSERIDFIELD.index = 0
var_0_2.SIMPLEPLAYERINFOUSERIDFIELD.label = 1
var_0_2.SIMPLEPLAYERINFOUSERIDFIELD.has_default_value = false
var_0_2.SIMPLEPLAYERINFOUSERIDFIELD.default_value = 0
var_0_2.SIMPLEPLAYERINFOUSERIDFIELD.type = 4
var_0_2.SIMPLEPLAYERINFOUSERIDFIELD.cpp_type = 4
var_0_2.SIMPLEPLAYERINFONAMEFIELD.name = "name"
var_0_2.SIMPLEPLAYERINFONAMEFIELD.full_name = ".SimplePlayerInfo.name"
var_0_2.SIMPLEPLAYERINFONAMEFIELD.number = 2
var_0_2.SIMPLEPLAYERINFONAMEFIELD.index = 1
var_0_2.SIMPLEPLAYERINFONAMEFIELD.label = 1
var_0_2.SIMPLEPLAYERINFONAMEFIELD.has_default_value = false
var_0_2.SIMPLEPLAYERINFONAMEFIELD.default_value = ""
var_0_2.SIMPLEPLAYERINFONAMEFIELD.type = 9
var_0_2.SIMPLEPLAYERINFONAMEFIELD.cpp_type = 9
var_0_2.SIMPLEPLAYERINFOPORTRAITFIELD.name = "portrait"
var_0_2.SIMPLEPLAYERINFOPORTRAITFIELD.full_name = ".SimplePlayerInfo.portrait"
var_0_2.SIMPLEPLAYERINFOPORTRAITFIELD.number = 3
var_0_2.SIMPLEPLAYERINFOPORTRAITFIELD.index = 2
var_0_2.SIMPLEPLAYERINFOPORTRAITFIELD.label = 1
var_0_2.SIMPLEPLAYERINFOPORTRAITFIELD.has_default_value = false
var_0_2.SIMPLEPLAYERINFOPORTRAITFIELD.default_value = 0
var_0_2.SIMPLEPLAYERINFOPORTRAITFIELD.type = 5
var_0_2.SIMPLEPLAYERINFOPORTRAITFIELD.cpp_type = 1
var_0_2.SIMPLEPLAYERINFOLEVELFIELD.name = "level"
var_0_2.SIMPLEPLAYERINFOLEVELFIELD.full_name = ".SimplePlayerInfo.level"
var_0_2.SIMPLEPLAYERINFOLEVELFIELD.number = 4
var_0_2.SIMPLEPLAYERINFOLEVELFIELD.index = 3
var_0_2.SIMPLEPLAYERINFOLEVELFIELD.label = 1
var_0_2.SIMPLEPLAYERINFOLEVELFIELD.has_default_value = false
var_0_2.SIMPLEPLAYERINFOLEVELFIELD.default_value = 0
var_0_2.SIMPLEPLAYERINFOLEVELFIELD.type = 5
var_0_2.SIMPLEPLAYERINFOLEVELFIELD.cpp_type = 1
var_0_2.SIMPLEPLAYERINFOISONLINEFIELD.name = "isOnline"
var_0_2.SIMPLEPLAYERINFOISONLINEFIELD.full_name = ".SimplePlayerInfo.isOnline"
var_0_2.SIMPLEPLAYERINFOISONLINEFIELD.number = 5
var_0_2.SIMPLEPLAYERINFOISONLINEFIELD.index = 4
var_0_2.SIMPLEPLAYERINFOISONLINEFIELD.label = 1
var_0_2.SIMPLEPLAYERINFOISONLINEFIELD.has_default_value = false
var_0_2.SIMPLEPLAYERINFOISONLINEFIELD.default_value = false
var_0_2.SIMPLEPLAYERINFOISONLINEFIELD.type = 8
var_0_2.SIMPLEPLAYERINFOISONLINEFIELD.cpp_type = 7
var_0_2.SIMPLEPLAYERINFOZONEIDFIELD.name = "zoneId"
var_0_2.SIMPLEPLAYERINFOZONEIDFIELD.full_name = ".SimplePlayerInfo.zoneId"
var_0_2.SIMPLEPLAYERINFOZONEIDFIELD.number = 6
var_0_2.SIMPLEPLAYERINFOZONEIDFIELD.index = 5
var_0_2.SIMPLEPLAYERINFOZONEIDFIELD.label = 1
var_0_2.SIMPLEPLAYERINFOZONEIDFIELD.has_default_value = false
var_0_2.SIMPLEPLAYERINFOZONEIDFIELD.default_value = 0
var_0_2.SIMPLEPLAYERINFOZONEIDFIELD.type = 5
var_0_2.SIMPLEPLAYERINFOZONEIDFIELD.cpp_type = 1
var_0_2.SIMPLEPLAYERINFODATETIMEFIELD.name = "datetime"
var_0_2.SIMPLEPLAYERINFODATETIMEFIELD.full_name = ".SimplePlayerInfo.datetime"
var_0_2.SIMPLEPLAYERINFODATETIMEFIELD.number = 7
var_0_2.SIMPLEPLAYERINFODATETIMEFIELD.index = 6
var_0_2.SIMPLEPLAYERINFODATETIMEFIELD.label = 1
var_0_2.SIMPLEPLAYERINFODATETIMEFIELD.has_default_value = false
var_0_2.SIMPLEPLAYERINFODATETIMEFIELD.default_value = 0
var_0_2.SIMPLEPLAYERINFODATETIMEFIELD.type = 5
var_0_2.SIMPLEPLAYERINFODATETIMEFIELD.cpp_type = 1
var_0_2.SIMPLEPLAYERINFO_MSG.name = "SimplePlayerInfo"
var_0_2.SIMPLEPLAYERINFO_MSG.full_name = ".SimplePlayerInfo"
var_0_2.SIMPLEPLAYERINFO_MSG.nested_types = {}
var_0_2.SIMPLEPLAYERINFO_MSG.enum_types = {}
var_0_2.SIMPLEPLAYERINFO_MSG.fields = {
	var_0_2.SIMPLEPLAYERINFOUSERIDFIELD,
	var_0_2.SIMPLEPLAYERINFONAMEFIELD,
	var_0_2.SIMPLEPLAYERINFOPORTRAITFIELD,
	var_0_2.SIMPLEPLAYERINFOLEVELFIELD,
	var_0_2.SIMPLEPLAYERINFOISONLINEFIELD,
	var_0_2.SIMPLEPLAYERINFOZONEIDFIELD,
	var_0_2.SIMPLEPLAYERINFODATETIMEFIELD
}
var_0_2.SIMPLEPLAYERINFO_MSG.is_extendable = false
var_0_2.SIMPLEPLAYERINFO_MSG.extensions = {}
var_0_2.PLAYERCLOTHCLOTHIDFIELD.name = "clothId"
var_0_2.PLAYERCLOTHCLOTHIDFIELD.full_name = ".PlayerCloth.clothId"
var_0_2.PLAYERCLOTHCLOTHIDFIELD.number = 1
var_0_2.PLAYERCLOTHCLOTHIDFIELD.index = 0
var_0_2.PLAYERCLOTHCLOTHIDFIELD.label = 1
var_0_2.PLAYERCLOTHCLOTHIDFIELD.has_default_value = false
var_0_2.PLAYERCLOTHCLOTHIDFIELD.default_value = 0
var_0_2.PLAYERCLOTHCLOTHIDFIELD.type = 5
var_0_2.PLAYERCLOTHCLOTHIDFIELD.cpp_type = 1
var_0_2.PLAYERCLOTHLEVELFIELD.name = "level"
var_0_2.PLAYERCLOTHLEVELFIELD.full_name = ".PlayerCloth.level"
var_0_2.PLAYERCLOTHLEVELFIELD.number = 2
var_0_2.PLAYERCLOTHLEVELFIELD.index = 1
var_0_2.PLAYERCLOTHLEVELFIELD.label = 1
var_0_2.PLAYERCLOTHLEVELFIELD.has_default_value = false
var_0_2.PLAYERCLOTHLEVELFIELD.default_value = 0
var_0_2.PLAYERCLOTHLEVELFIELD.type = 5
var_0_2.PLAYERCLOTHLEVELFIELD.cpp_type = 1
var_0_2.PLAYERCLOTHEXPFIELD.name = "exp"
var_0_2.PLAYERCLOTHEXPFIELD.full_name = ".PlayerCloth.exp"
var_0_2.PLAYERCLOTHEXPFIELD.number = 3
var_0_2.PLAYERCLOTHEXPFIELD.index = 2
var_0_2.PLAYERCLOTHEXPFIELD.label = 1
var_0_2.PLAYERCLOTHEXPFIELD.has_default_value = false
var_0_2.PLAYERCLOTHEXPFIELD.default_value = 0
var_0_2.PLAYERCLOTHEXPFIELD.type = 5
var_0_2.PLAYERCLOTHEXPFIELD.cpp_type = 1
var_0_2.PLAYERCLOTH_MSG.name = "PlayerCloth"
var_0_2.PLAYERCLOTH_MSG.full_name = ".PlayerCloth"
var_0_2.PLAYERCLOTH_MSG.nested_types = {}
var_0_2.PLAYERCLOTH_MSG.enum_types = {}
var_0_2.PLAYERCLOTH_MSG.fields = {
	var_0_2.PLAYERCLOTHCLOTHIDFIELD,
	var_0_2.PLAYERCLOTHLEVELFIELD,
	var_0_2.PLAYERCLOTHEXPFIELD
}
var_0_2.PLAYERCLOTH_MSG.is_extendable = false
var_0_2.PLAYERCLOTH_MSG.extensions = {}
var_0_2.PLAYERINFOUSERIDFIELD.name = "userId"
var_0_2.PLAYERINFOUSERIDFIELD.full_name = ".PlayerInfo.userId"
var_0_2.PLAYERINFOUSERIDFIELD.number = 1
var_0_2.PLAYERINFOUSERIDFIELD.index = 0
var_0_2.PLAYERINFOUSERIDFIELD.label = 1
var_0_2.PLAYERINFOUSERIDFIELD.has_default_value = false
var_0_2.PLAYERINFOUSERIDFIELD.default_value = 0
var_0_2.PLAYERINFOUSERIDFIELD.type = 4
var_0_2.PLAYERINFOUSERIDFIELD.cpp_type = 4
var_0_2.PLAYERINFONAMEFIELD.name = "name"
var_0_2.PLAYERINFONAMEFIELD.full_name = ".PlayerInfo.name"
var_0_2.PLAYERINFONAMEFIELD.number = 2
var_0_2.PLAYERINFONAMEFIELD.index = 1
var_0_2.PLAYERINFONAMEFIELD.label = 1
var_0_2.PLAYERINFONAMEFIELD.has_default_value = false
var_0_2.PLAYERINFONAMEFIELD.default_value = ""
var_0_2.PLAYERINFONAMEFIELD.type = 9
var_0_2.PLAYERINFONAMEFIELD.cpp_type = 9
var_0_2.PLAYERINFOPORTRAITFIELD.name = "portrait"
var_0_2.PLAYERINFOPORTRAITFIELD.full_name = ".PlayerInfo.portrait"
var_0_2.PLAYERINFOPORTRAITFIELD.number = 3
var_0_2.PLAYERINFOPORTRAITFIELD.index = 2
var_0_2.PLAYERINFOPORTRAITFIELD.label = 1
var_0_2.PLAYERINFOPORTRAITFIELD.has_default_value = false
var_0_2.PLAYERINFOPORTRAITFIELD.default_value = 0
var_0_2.PLAYERINFOPORTRAITFIELD.type = 5
var_0_2.PLAYERINFOPORTRAITFIELD.cpp_type = 1
var_0_2.PLAYERINFOLEVELFIELD.name = "level"
var_0_2.PLAYERINFOLEVELFIELD.full_name = ".PlayerInfo.level"
var_0_2.PLAYERINFOLEVELFIELD.number = 4
var_0_2.PLAYERINFOLEVELFIELD.index = 3
var_0_2.PLAYERINFOLEVELFIELD.label = 1
var_0_2.PLAYERINFOLEVELFIELD.has_default_value = false
var_0_2.PLAYERINFOLEVELFIELD.default_value = 0
var_0_2.PLAYERINFOLEVELFIELD.type = 5
var_0_2.PLAYERINFOLEVELFIELD.cpp_type = 1
var_0_2.PLAYERINFOEXPFIELD.name = "exp"
var_0_2.PLAYERINFOEXPFIELD.full_name = ".PlayerInfo.exp"
var_0_2.PLAYERINFOEXPFIELD.number = 5
var_0_2.PLAYERINFOEXPFIELD.index = 4
var_0_2.PLAYERINFOEXPFIELD.label = 1
var_0_2.PLAYERINFOEXPFIELD.has_default_value = false
var_0_2.PLAYERINFOEXPFIELD.default_value = 0
var_0_2.PLAYERINFOEXPFIELD.type = 5
var_0_2.PLAYERINFOEXPFIELD.cpp_type = 1
var_0_2.PLAYERINFOSIGNATUREFIELD.name = "signature"
var_0_2.PLAYERINFOSIGNATUREFIELD.full_name = ".PlayerInfo.signature"
var_0_2.PLAYERINFOSIGNATUREFIELD.number = 6
var_0_2.PLAYERINFOSIGNATUREFIELD.index = 5
var_0_2.PLAYERINFOSIGNATUREFIELD.label = 1
var_0_2.PLAYERINFOSIGNATUREFIELD.has_default_value = false
var_0_2.PLAYERINFOSIGNATUREFIELD.default_value = ""
var_0_2.PLAYERINFOSIGNATUREFIELD.type = 9
var_0_2.PLAYERINFOSIGNATUREFIELD.cpp_type = 9
var_0_2.PLAYERINFOBIRTHDAYFIELD.name = "birthday"
var_0_2.PLAYERINFOBIRTHDAYFIELD.full_name = ".PlayerInfo.birthday"
var_0_2.PLAYERINFOBIRTHDAYFIELD.number = 7
var_0_2.PLAYERINFOBIRTHDAYFIELD.index = 6
var_0_2.PLAYERINFOBIRTHDAYFIELD.label = 1
var_0_2.PLAYERINFOBIRTHDAYFIELD.has_default_value = false
var_0_2.PLAYERINFOBIRTHDAYFIELD.default_value = ""
var_0_2.PLAYERINFOBIRTHDAYFIELD.type = 9
var_0_2.PLAYERINFOBIRTHDAYFIELD.cpp_type = 9
var_0_2.PLAYERINFOSHOWHEROSFIELD.name = "showHeros"
var_0_2.PLAYERINFOSHOWHEROSFIELD.full_name = ".PlayerInfo.showHeros"
var_0_2.PLAYERINFOSHOWHEROSFIELD.number = 8
var_0_2.PLAYERINFOSHOWHEROSFIELD.index = 7
var_0_2.PLAYERINFOSHOWHEROSFIELD.label = 3
var_0_2.PLAYERINFOSHOWHEROSFIELD.has_default_value = false
var_0_2.PLAYERINFOSHOWHEROSFIELD.default_value = {}
var_0_2.PLAYERINFOSHOWHEROSFIELD.message_type = var_0_2.HERODEF_PB.HEROSIMPLEINFO_MSG
var_0_2.PLAYERINFOSHOWHEROSFIELD.type = 11
var_0_2.PLAYERINFOSHOWHEROSFIELD.cpp_type = 10
var_0_2.PLAYERINFOREGISTERTIMEFIELD.name = "registerTime"
var_0_2.PLAYERINFOREGISTERTIMEFIELD.full_name = ".PlayerInfo.registerTime"
var_0_2.PLAYERINFOREGISTERTIMEFIELD.number = 9
var_0_2.PLAYERINFOREGISTERTIMEFIELD.index = 8
var_0_2.PLAYERINFOREGISTERTIMEFIELD.label = 1
var_0_2.PLAYERINFOREGISTERTIMEFIELD.has_default_value = false
var_0_2.PLAYERINFOREGISTERTIMEFIELD.default_value = 0
var_0_2.PLAYERINFOREGISTERTIMEFIELD.type = 3
var_0_2.PLAYERINFOREGISTERTIMEFIELD.cpp_type = 2
var_0_2.PLAYERINFOHERORARENNCOUNTFIELD.name = "heroRareNNCount"
var_0_2.PLAYERINFOHERORARENNCOUNTFIELD.full_name = ".PlayerInfo.heroRareNNCount"
var_0_2.PLAYERINFOHERORARENNCOUNTFIELD.number = 10
var_0_2.PLAYERINFOHERORARENNCOUNTFIELD.index = 9
var_0_2.PLAYERINFOHERORARENNCOUNTFIELD.label = 1
var_0_2.PLAYERINFOHERORARENNCOUNTFIELD.has_default_value = false
var_0_2.PLAYERINFOHERORARENNCOUNTFIELD.default_value = 0
var_0_2.PLAYERINFOHERORARENNCOUNTFIELD.type = 5
var_0_2.PLAYERINFOHERORARENNCOUNTFIELD.cpp_type = 1
var_0_2.PLAYERINFOHERORARENCOUNTFIELD.name = "heroRareNCount"
var_0_2.PLAYERINFOHERORARENCOUNTFIELD.full_name = ".PlayerInfo.heroRareNCount"
var_0_2.PLAYERINFOHERORARENCOUNTFIELD.number = 11
var_0_2.PLAYERINFOHERORARENCOUNTFIELD.index = 10
var_0_2.PLAYERINFOHERORARENCOUNTFIELD.label = 1
var_0_2.PLAYERINFOHERORARENCOUNTFIELD.has_default_value = false
var_0_2.PLAYERINFOHERORARENCOUNTFIELD.default_value = 0
var_0_2.PLAYERINFOHERORARENCOUNTFIELD.type = 5
var_0_2.PLAYERINFOHERORARENCOUNTFIELD.cpp_type = 1
var_0_2.PLAYERINFOHERORARERCOUNTFIELD.name = "heroRareRCount"
var_0_2.PLAYERINFOHERORARERCOUNTFIELD.full_name = ".PlayerInfo.heroRareRCount"
var_0_2.PLAYERINFOHERORARERCOUNTFIELD.number = 12
var_0_2.PLAYERINFOHERORARERCOUNTFIELD.index = 11
var_0_2.PLAYERINFOHERORARERCOUNTFIELD.label = 1
var_0_2.PLAYERINFOHERORARERCOUNTFIELD.has_default_value = false
var_0_2.PLAYERINFOHERORARERCOUNTFIELD.default_value = 0
var_0_2.PLAYERINFOHERORARERCOUNTFIELD.type = 5
var_0_2.PLAYERINFOHERORARERCOUNTFIELD.cpp_type = 1
var_0_2.PLAYERINFOHERORARESRCOUNTFIELD.name = "heroRareSRCount"
var_0_2.PLAYERINFOHERORARESRCOUNTFIELD.full_name = ".PlayerInfo.heroRareSRCount"
var_0_2.PLAYERINFOHERORARESRCOUNTFIELD.number = 13
var_0_2.PLAYERINFOHERORARESRCOUNTFIELD.index = 12
var_0_2.PLAYERINFOHERORARESRCOUNTFIELD.label = 1
var_0_2.PLAYERINFOHERORARESRCOUNTFIELD.has_default_value = false
var_0_2.PLAYERINFOHERORARESRCOUNTFIELD.default_value = 0
var_0_2.PLAYERINFOHERORARESRCOUNTFIELD.type = 5
var_0_2.PLAYERINFOHERORARESRCOUNTFIELD.cpp_type = 1
var_0_2.PLAYERINFOHERORARESSRCOUNTFIELD.name = "heroRareSSRCount"
var_0_2.PLAYERINFOHERORARESSRCOUNTFIELD.full_name = ".PlayerInfo.heroRareSSRCount"
var_0_2.PLAYERINFOHERORARESSRCOUNTFIELD.number = 14
var_0_2.PLAYERINFOHERORARESSRCOUNTFIELD.index = 13
var_0_2.PLAYERINFOHERORARESSRCOUNTFIELD.label = 1
var_0_2.PLAYERINFOHERORARESSRCOUNTFIELD.has_default_value = false
var_0_2.PLAYERINFOHERORARESSRCOUNTFIELD.default_value = 0
var_0_2.PLAYERINFOHERORARESSRCOUNTFIELD.type = 5
var_0_2.PLAYERINFOHERORARESSRCOUNTFIELD.cpp_type = 1
var_0_2.PLAYERINFOLASTEPISODEIDFIELD.name = "lastEpisodeId"
var_0_2.PLAYERINFOLASTEPISODEIDFIELD.full_name = ".PlayerInfo.lastEpisodeId"
var_0_2.PLAYERINFOLASTEPISODEIDFIELD.number = 15
var_0_2.PLAYERINFOLASTEPISODEIDFIELD.index = 14
var_0_2.PLAYERINFOLASTEPISODEIDFIELD.label = 1
var_0_2.PLAYERINFOLASTEPISODEIDFIELD.has_default_value = false
var_0_2.PLAYERINFOLASTEPISODEIDFIELD.default_value = 0
var_0_2.PLAYERINFOLASTEPISODEIDFIELD.type = 5
var_0_2.PLAYERINFOLASTEPISODEIDFIELD.cpp_type = 1
var_0_2.PLAYERINFOLASTLOGINTIMEFIELD.name = "lastLoginTime"
var_0_2.PLAYERINFOLASTLOGINTIMEFIELD.full_name = ".PlayerInfo.lastLoginTime"
var_0_2.PLAYERINFOLASTLOGINTIMEFIELD.number = 16
var_0_2.PLAYERINFOLASTLOGINTIMEFIELD.index = 15
var_0_2.PLAYERINFOLASTLOGINTIMEFIELD.label = 1
var_0_2.PLAYERINFOLASTLOGINTIMEFIELD.has_default_value = false
var_0_2.PLAYERINFOLASTLOGINTIMEFIELD.default_value = 0
var_0_2.PLAYERINFOLASTLOGINTIMEFIELD.type = 3
var_0_2.PLAYERINFOLASTLOGINTIMEFIELD.cpp_type = 2
var_0_2.PLAYERINFOLASTLOGOUTTIMEFIELD.name = "lastLogoutTime"
var_0_2.PLAYERINFOLASTLOGOUTTIMEFIELD.full_name = ".PlayerInfo.lastLogoutTime"
var_0_2.PLAYERINFOLASTLOGOUTTIMEFIELD.number = 17
var_0_2.PLAYERINFOLASTLOGOUTTIMEFIELD.index = 16
var_0_2.PLAYERINFOLASTLOGOUTTIMEFIELD.label = 1
var_0_2.PLAYERINFOLASTLOGOUTTIMEFIELD.has_default_value = false
var_0_2.PLAYERINFOLASTLOGOUTTIMEFIELD.default_value = 0
var_0_2.PLAYERINFOLASTLOGOUTTIMEFIELD.type = 3
var_0_2.PLAYERINFOLASTLOGOUTTIMEFIELD.cpp_type = 2
var_0_2.PLAYERINFOCHARACTERAGEFIELD.name = "characterAge"
var_0_2.PLAYERINFOCHARACTERAGEFIELD.full_name = ".PlayerInfo.characterAge"
var_0_2.PLAYERINFOCHARACTERAGEFIELD.number = 18
var_0_2.PLAYERINFOCHARACTERAGEFIELD.index = 17
var_0_2.PLAYERINFOCHARACTERAGEFIELD.label = 3
var_0_2.PLAYERINFOCHARACTERAGEFIELD.has_default_value = false
var_0_2.PLAYERINFOCHARACTERAGEFIELD.default_value = {}
var_0_2.PLAYERINFOCHARACTERAGEFIELD.type = 5
var_0_2.PLAYERINFOCHARACTERAGEFIELD.cpp_type = 1
var_0_2.PLAYERINFOSHOWACHIEVEMENTFIELD.name = "showAchievement"
var_0_2.PLAYERINFOSHOWACHIEVEMENTFIELD.full_name = ".PlayerInfo.showAchievement"
var_0_2.PLAYERINFOSHOWACHIEVEMENTFIELD.number = 19
var_0_2.PLAYERINFOSHOWACHIEVEMENTFIELD.index = 18
var_0_2.PLAYERINFOSHOWACHIEVEMENTFIELD.label = 1
var_0_2.PLAYERINFOSHOWACHIEVEMENTFIELD.has_default_value = false
var_0_2.PLAYERINFOSHOWACHIEVEMENTFIELD.default_value = ""
var_0_2.PLAYERINFOSHOWACHIEVEMENTFIELD.type = 9
var_0_2.PLAYERINFOSHOWACHIEVEMENTFIELD.cpp_type = 9
var_0_2.PLAYERINFOBGFIELD.name = "bg"
var_0_2.PLAYERINFOBGFIELD.full_name = ".PlayerInfo.bg"
var_0_2.PLAYERINFOBGFIELD.number = 20
var_0_2.PLAYERINFOBGFIELD.index = 19
var_0_2.PLAYERINFOBGFIELD.label = 1
var_0_2.PLAYERINFOBGFIELD.has_default_value = false
var_0_2.PLAYERINFOBGFIELD.default_value = 0
var_0_2.PLAYERINFOBGFIELD.type = 5
var_0_2.PLAYERINFOBGFIELD.cpp_type = 1
var_0_2.PLAYERINFOTOTALLOGINDAYSFIELD.name = "totalLoginDays"
var_0_2.PLAYERINFOTOTALLOGINDAYSFIELD.full_name = ".PlayerInfo.totalLoginDays"
var_0_2.PLAYERINFOTOTALLOGINDAYSFIELD.number = 21
var_0_2.PLAYERINFOTOTALLOGINDAYSFIELD.index = 20
var_0_2.PLAYERINFOTOTALLOGINDAYSFIELD.label = 1
var_0_2.PLAYERINFOTOTALLOGINDAYSFIELD.has_default_value = false
var_0_2.PLAYERINFOTOTALLOGINDAYSFIELD.default_value = 0
var_0_2.PLAYERINFOTOTALLOGINDAYSFIELD.type = 5
var_0_2.PLAYERINFOTOTALLOGINDAYSFIELD.cpp_type = 1
var_0_2.PLAYERINFO_MSG.name = "PlayerInfo"
var_0_2.PLAYERINFO_MSG.full_name = ".PlayerInfo"
var_0_2.PLAYERINFO_MSG.nested_types = {}
var_0_2.PLAYERINFO_MSG.enum_types = {}
var_0_2.PLAYERINFO_MSG.fields = {
	var_0_2.PLAYERINFOUSERIDFIELD,
	var_0_2.PLAYERINFONAMEFIELD,
	var_0_2.PLAYERINFOPORTRAITFIELD,
	var_0_2.PLAYERINFOLEVELFIELD,
	var_0_2.PLAYERINFOEXPFIELD,
	var_0_2.PLAYERINFOSIGNATUREFIELD,
	var_0_2.PLAYERINFOBIRTHDAYFIELD,
	var_0_2.PLAYERINFOSHOWHEROSFIELD,
	var_0_2.PLAYERINFOREGISTERTIMEFIELD,
	var_0_2.PLAYERINFOHERORARENNCOUNTFIELD,
	var_0_2.PLAYERINFOHERORARENCOUNTFIELD,
	var_0_2.PLAYERINFOHERORARERCOUNTFIELD,
	var_0_2.PLAYERINFOHERORARESRCOUNTFIELD,
	var_0_2.PLAYERINFOHERORARESSRCOUNTFIELD,
	var_0_2.PLAYERINFOLASTEPISODEIDFIELD,
	var_0_2.PLAYERINFOLASTLOGINTIMEFIELD,
	var_0_2.PLAYERINFOLASTLOGOUTTIMEFIELD,
	var_0_2.PLAYERINFOCHARACTERAGEFIELD,
	var_0_2.PLAYERINFOSHOWACHIEVEMENTFIELD,
	var_0_2.PLAYERINFOBGFIELD,
	var_0_2.PLAYERINFOTOTALLOGINDAYSFIELD
}
var_0_2.PLAYERINFO_MSG.is_extendable = false
var_0_2.PLAYERINFO_MSG.extensions = {}
var_0_2.PLAYERCLOTHINFOCLOTHESFIELD.name = "clothes"
var_0_2.PLAYERCLOTHINFOCLOTHESFIELD.full_name = ".PlayerClothInfo.clothes"
var_0_2.PLAYERCLOTHINFOCLOTHESFIELD.number = 1
var_0_2.PLAYERCLOTHINFOCLOTHESFIELD.index = 0
var_0_2.PLAYERCLOTHINFOCLOTHESFIELD.label = 3
var_0_2.PLAYERCLOTHINFOCLOTHESFIELD.has_default_value = false
var_0_2.PLAYERCLOTHINFOCLOTHESFIELD.default_value = {}
var_0_2.PLAYERCLOTHINFOCLOTHESFIELD.message_type = var_0_2.PLAYERCLOTH_MSG
var_0_2.PLAYERCLOTHINFOCLOTHESFIELD.type = 11
var_0_2.PLAYERCLOTHINFOCLOTHESFIELD.cpp_type = 10
var_0_2.PLAYERCLOTHINFO_MSG.name = "PlayerClothInfo"
var_0_2.PLAYERCLOTHINFO_MSG.full_name = ".PlayerClothInfo"
var_0_2.PLAYERCLOTHINFO_MSG.nested_types = {}
var_0_2.PLAYERCLOTHINFO_MSG.enum_types = {}
var_0_2.PLAYERCLOTHINFO_MSG.fields = {
	var_0_2.PLAYERCLOTHINFOCLOTHESFIELD
}
var_0_2.PLAYERCLOTHINFO_MSG.is_extendable = false
var_0_2.PLAYERCLOTHINFO_MSG.extensions = {}
var_0_2.PLAYERCARDINFOSHOWSETTINGSFIELD.name = "showSettings"
var_0_2.PLAYERCARDINFOSHOWSETTINGSFIELD.full_name = ".PlayerCardInfo.showSettings"
var_0_2.PLAYERCARDINFOSHOWSETTINGSFIELD.number = 1
var_0_2.PLAYERCARDINFOSHOWSETTINGSFIELD.index = 0
var_0_2.PLAYERCARDINFOSHOWSETTINGSFIELD.label = 3
var_0_2.PLAYERCARDINFOSHOWSETTINGSFIELD.has_default_value = false
var_0_2.PLAYERCARDINFOSHOWSETTINGSFIELD.default_value = {}
var_0_2.PLAYERCARDINFOSHOWSETTINGSFIELD.type = 9
var_0_2.PLAYERCARDINFOSHOWSETTINGSFIELD.cpp_type = 9
var_0_2.PLAYERCARDINFOPROGRESSSETTINGFIELD.name = "progressSetting"
var_0_2.PLAYERCARDINFOPROGRESSSETTINGFIELD.full_name = ".PlayerCardInfo.progressSetting"
var_0_2.PLAYERCARDINFOPROGRESSSETTINGFIELD.number = 2
var_0_2.PLAYERCARDINFOPROGRESSSETTINGFIELD.index = 1
var_0_2.PLAYERCARDINFOPROGRESSSETTINGFIELD.label = 1
var_0_2.PLAYERCARDINFOPROGRESSSETTINGFIELD.has_default_value = false
var_0_2.PLAYERCARDINFOPROGRESSSETTINGFIELD.default_value = ""
var_0_2.PLAYERCARDINFOPROGRESSSETTINGFIELD.type = 9
var_0_2.PLAYERCARDINFOPROGRESSSETTINGFIELD.cpp_type = 9
var_0_2.PLAYERCARDINFOBASESETTINGFIELD.name = "baseSetting"
var_0_2.PLAYERCARDINFOBASESETTINGFIELD.full_name = ".PlayerCardInfo.baseSetting"
var_0_2.PLAYERCARDINFOBASESETTINGFIELD.number = 3
var_0_2.PLAYERCARDINFOBASESETTINGFIELD.index = 2
var_0_2.PLAYERCARDINFOBASESETTINGFIELD.label = 1
var_0_2.PLAYERCARDINFOBASESETTINGFIELD.has_default_value = false
var_0_2.PLAYERCARDINFOBASESETTINGFIELD.default_value = ""
var_0_2.PLAYERCARDINFOBASESETTINGFIELD.type = 9
var_0_2.PLAYERCARDINFOBASESETTINGFIELD.cpp_type = 9
var_0_2.PLAYERCARDINFOHEROCOVERFIELD.name = "heroCover"
var_0_2.PLAYERCARDINFOHEROCOVERFIELD.full_name = ".PlayerCardInfo.heroCover"
var_0_2.PLAYERCARDINFOHEROCOVERFIELD.number = 4
var_0_2.PLAYERCARDINFOHEROCOVERFIELD.index = 3
var_0_2.PLAYERCARDINFOHEROCOVERFIELD.label = 1
var_0_2.PLAYERCARDINFOHEROCOVERFIELD.has_default_value = false
var_0_2.PLAYERCARDINFOHEROCOVERFIELD.default_value = ""
var_0_2.PLAYERCARDINFOHEROCOVERFIELD.type = 9
var_0_2.PLAYERCARDINFOHEROCOVERFIELD.cpp_type = 9
var_0_2.PLAYERCARDINFOTHEMEIDFIELD.name = "themeId"
var_0_2.PLAYERCARDINFOTHEMEIDFIELD.full_name = ".PlayerCardInfo.themeId"
var_0_2.PLAYERCARDINFOTHEMEIDFIELD.number = 5
var_0_2.PLAYERCARDINFOTHEMEIDFIELD.index = 4
var_0_2.PLAYERCARDINFOTHEMEIDFIELD.label = 1
var_0_2.PLAYERCARDINFOTHEMEIDFIELD.has_default_value = false
var_0_2.PLAYERCARDINFOTHEMEIDFIELD.default_value = 0
var_0_2.PLAYERCARDINFOTHEMEIDFIELD.type = 5
var_0_2.PLAYERCARDINFOTHEMEIDFIELD.cpp_type = 1
var_0_2.PLAYERCARDINFOSHOWACHIEVEMENTFIELD.name = "showAchievement"
var_0_2.PLAYERCARDINFOSHOWACHIEVEMENTFIELD.full_name = ".PlayerCardInfo.showAchievement"
var_0_2.PLAYERCARDINFOSHOWACHIEVEMENTFIELD.number = 6
var_0_2.PLAYERCARDINFOSHOWACHIEVEMENTFIELD.index = 5
var_0_2.PLAYERCARDINFOSHOWACHIEVEMENTFIELD.label = 1
var_0_2.PLAYERCARDINFOSHOWACHIEVEMENTFIELD.has_default_value = false
var_0_2.PLAYERCARDINFOSHOWACHIEVEMENTFIELD.default_value = ""
var_0_2.PLAYERCARDINFOSHOWACHIEVEMENTFIELD.type = 9
var_0_2.PLAYERCARDINFOSHOWACHIEVEMENTFIELD.cpp_type = 9
var_0_2.PLAYERCARDINFOCRITTERFIELD.name = "critter"
var_0_2.PLAYERCARDINFOCRITTERFIELD.full_name = ".PlayerCardInfo.critter"
var_0_2.PLAYERCARDINFOCRITTERFIELD.number = 7
var_0_2.PLAYERCARDINFOCRITTERFIELD.index = 6
var_0_2.PLAYERCARDINFOCRITTERFIELD.label = 1
var_0_2.PLAYERCARDINFOCRITTERFIELD.has_default_value = false
var_0_2.PLAYERCARDINFOCRITTERFIELD.default_value = ""
var_0_2.PLAYERCARDINFOCRITTERFIELD.type = 9
var_0_2.PLAYERCARDINFOCRITTERFIELD.cpp_type = 9
var_0_2.PLAYERCARDINFOROOMCOLLECTIONFIELD.name = "roomCollection"
var_0_2.PLAYERCARDINFOROOMCOLLECTIONFIELD.full_name = ".PlayerCardInfo.roomCollection"
var_0_2.PLAYERCARDINFOROOMCOLLECTIONFIELD.number = 8
var_0_2.PLAYERCARDINFOROOMCOLLECTIONFIELD.index = 7
var_0_2.PLAYERCARDINFOROOMCOLLECTIONFIELD.label = 1
var_0_2.PLAYERCARDINFOROOMCOLLECTIONFIELD.has_default_value = false
var_0_2.PLAYERCARDINFOROOMCOLLECTIONFIELD.default_value = ""
var_0_2.PLAYERCARDINFOROOMCOLLECTIONFIELD.type = 9
var_0_2.PLAYERCARDINFOROOMCOLLECTIONFIELD.cpp_type = 9
var_0_2.PLAYERCARDINFOWEEKWALKDEEPLAYERIDFIELD.name = "weekwalkDeepLayerId"
var_0_2.PLAYERCARDINFOWEEKWALKDEEPLAYERIDFIELD.full_name = ".PlayerCardInfo.weekwalkDeepLayerId"
var_0_2.PLAYERCARDINFOWEEKWALKDEEPLAYERIDFIELD.number = 9
var_0_2.PLAYERCARDINFOWEEKWALKDEEPLAYERIDFIELD.index = 8
var_0_2.PLAYERCARDINFOWEEKWALKDEEPLAYERIDFIELD.label = 1
var_0_2.PLAYERCARDINFOWEEKWALKDEEPLAYERIDFIELD.has_default_value = false
var_0_2.PLAYERCARDINFOWEEKWALKDEEPLAYERIDFIELD.default_value = 0
var_0_2.PLAYERCARDINFOWEEKWALKDEEPLAYERIDFIELD.type = 5
var_0_2.PLAYERCARDINFOWEEKWALKDEEPLAYERIDFIELD.cpp_type = 1
var_0_2.PLAYERCARDINFOEXPLORECOLLECTIONFIELD.name = "exploreCollection"
var_0_2.PLAYERCARDINFOEXPLORECOLLECTIONFIELD.full_name = ".PlayerCardInfo.exploreCollection"
var_0_2.PLAYERCARDINFOEXPLORECOLLECTIONFIELD.number = 10
var_0_2.PLAYERCARDINFOEXPLORECOLLECTIONFIELD.index = 9
var_0_2.PLAYERCARDINFOEXPLORECOLLECTIONFIELD.label = 1
var_0_2.PLAYERCARDINFOEXPLORECOLLECTIONFIELD.has_default_value = false
var_0_2.PLAYERCARDINFOEXPLORECOLLECTIONFIELD.default_value = ""
var_0_2.PLAYERCARDINFOEXPLORECOLLECTIONFIELD.type = 9
var_0_2.PLAYERCARDINFOEXPLORECOLLECTIONFIELD.cpp_type = 9
var_0_2.PLAYERCARDINFOROUGEDIFFICULTYFIELD.name = "rougeDifficulty"
var_0_2.PLAYERCARDINFOROUGEDIFFICULTYFIELD.full_name = ".PlayerCardInfo.rougeDifficulty"
var_0_2.PLAYERCARDINFOROUGEDIFFICULTYFIELD.number = 11
var_0_2.PLAYERCARDINFOROUGEDIFFICULTYFIELD.index = 10
var_0_2.PLAYERCARDINFOROUGEDIFFICULTYFIELD.label = 1
var_0_2.PLAYERCARDINFOROUGEDIFFICULTYFIELD.has_default_value = false
var_0_2.PLAYERCARDINFOROUGEDIFFICULTYFIELD.default_value = 0
var_0_2.PLAYERCARDINFOROUGEDIFFICULTYFIELD.type = 5
var_0_2.PLAYERCARDINFOROUGEDIFFICULTYFIELD.cpp_type = 1
var_0_2.PLAYERCARDINFOACT128SSSCOUNTFIELD.name = "act128SSSCount"
var_0_2.PLAYERCARDINFOACT128SSSCOUNTFIELD.full_name = ".PlayerCardInfo.act128SSSCount"
var_0_2.PLAYERCARDINFOACT128SSSCOUNTFIELD.number = 12
var_0_2.PLAYERCARDINFOACT128SSSCOUNTFIELD.index = 11
var_0_2.PLAYERCARDINFOACT128SSSCOUNTFIELD.label = 1
var_0_2.PLAYERCARDINFOACT128SSSCOUNTFIELD.has_default_value = false
var_0_2.PLAYERCARDINFOACT128SSSCOUNTFIELD.default_value = 0
var_0_2.PLAYERCARDINFOACT128SSSCOUNTFIELD.type = 5
var_0_2.PLAYERCARDINFOACT128SSSCOUNTFIELD.cpp_type = 1
var_0_2.PLAYERCARDINFOACHIEVEMENTCOUNTFIELD.name = "achievementCount"
var_0_2.PLAYERCARDINFOACHIEVEMENTCOUNTFIELD.full_name = ".PlayerCardInfo.achievementCount"
var_0_2.PLAYERCARDINFOACHIEVEMENTCOUNTFIELD.number = 13
var_0_2.PLAYERCARDINFOACHIEVEMENTCOUNTFIELD.index = 12
var_0_2.PLAYERCARDINFOACHIEVEMENTCOUNTFIELD.label = 1
var_0_2.PLAYERCARDINFOACHIEVEMENTCOUNTFIELD.has_default_value = false
var_0_2.PLAYERCARDINFOACHIEVEMENTCOUNTFIELD.default_value = 0
var_0_2.PLAYERCARDINFOACHIEVEMENTCOUNTFIELD.type = 5
var_0_2.PLAYERCARDINFOACHIEVEMENTCOUNTFIELD.cpp_type = 1
var_0_2.PLAYERCARDINFOASSISTTIMESFIELD.name = "assistTimes"
var_0_2.PLAYERCARDINFOASSISTTIMESFIELD.full_name = ".PlayerCardInfo.assistTimes"
var_0_2.PLAYERCARDINFOASSISTTIMESFIELD.number = 14
var_0_2.PLAYERCARDINFOASSISTTIMESFIELD.index = 13
var_0_2.PLAYERCARDINFOASSISTTIMESFIELD.label = 1
var_0_2.PLAYERCARDINFOASSISTTIMESFIELD.has_default_value = false
var_0_2.PLAYERCARDINFOASSISTTIMESFIELD.default_value = 0
var_0_2.PLAYERCARDINFOASSISTTIMESFIELD.type = 5
var_0_2.PLAYERCARDINFOASSISTTIMESFIELD.cpp_type = 1
var_0_2.PLAYERCARDINFOHEROCOVERTIMESFIELD.name = "heroCoverTimes"
var_0_2.PLAYERCARDINFOHEROCOVERTIMESFIELD.full_name = ".PlayerCardInfo.heroCoverTimes"
var_0_2.PLAYERCARDINFOHEROCOVERTIMESFIELD.number = 15
var_0_2.PLAYERCARDINFOHEROCOVERTIMESFIELD.index = 14
var_0_2.PLAYERCARDINFOHEROCOVERTIMESFIELD.label = 1
var_0_2.PLAYERCARDINFOHEROCOVERTIMESFIELD.has_default_value = false
var_0_2.PLAYERCARDINFOHEROCOVERTIMESFIELD.default_value = 0
var_0_2.PLAYERCARDINFOHEROCOVERTIMESFIELD.type = 5
var_0_2.PLAYERCARDINFOHEROCOVERTIMESFIELD.cpp_type = 1
var_0_2.PLAYERCARDINFOMAXFAITHHEROCOUNTFIELD.name = "maxFaithHeroCount"
var_0_2.PLAYERCARDINFOMAXFAITHHEROCOUNTFIELD.full_name = ".PlayerCardInfo.maxFaithHeroCount"
var_0_2.PLAYERCARDINFOMAXFAITHHEROCOUNTFIELD.number = 16
var_0_2.PLAYERCARDINFOMAXFAITHHEROCOUNTFIELD.index = 15
var_0_2.PLAYERCARDINFOMAXFAITHHEROCOUNTFIELD.label = 1
var_0_2.PLAYERCARDINFOMAXFAITHHEROCOUNTFIELD.has_default_value = false
var_0_2.PLAYERCARDINFOMAXFAITHHEROCOUNTFIELD.default_value = 0
var_0_2.PLAYERCARDINFOMAXFAITHHEROCOUNTFIELD.type = 5
var_0_2.PLAYERCARDINFOMAXFAITHHEROCOUNTFIELD.cpp_type = 1
var_0_2.PLAYERCARDINFOTOTALCOSTPOWERFIELD.name = "totalCostPower"
var_0_2.PLAYERCARDINFOTOTALCOSTPOWERFIELD.full_name = ".PlayerCardInfo.totalCostPower"
var_0_2.PLAYERCARDINFOTOTALCOSTPOWERFIELD.number = 17
var_0_2.PLAYERCARDINFOTOTALCOSTPOWERFIELD.index = 16
var_0_2.PLAYERCARDINFOTOTALCOSTPOWERFIELD.label = 1
var_0_2.PLAYERCARDINFOTOTALCOSTPOWERFIELD.has_default_value = false
var_0_2.PLAYERCARDINFOTOTALCOSTPOWERFIELD.default_value = 0
var_0_2.PLAYERCARDINFOTOTALCOSTPOWERFIELD.type = 5
var_0_2.PLAYERCARDINFOTOTALCOSTPOWERFIELD.cpp_type = 1
var_0_2.PLAYERCARDINFOSKINCOUNTFIELD.name = "skinCount"
var_0_2.PLAYERCARDINFOSKINCOUNTFIELD.full_name = ".PlayerCardInfo.skinCount"
var_0_2.PLAYERCARDINFOSKINCOUNTFIELD.number = 18
var_0_2.PLAYERCARDINFOSKINCOUNTFIELD.index = 17
var_0_2.PLAYERCARDINFOSKINCOUNTFIELD.label = 1
var_0_2.PLAYERCARDINFOSKINCOUNTFIELD.has_default_value = false
var_0_2.PLAYERCARDINFOSKINCOUNTFIELD.default_value = 0
var_0_2.PLAYERCARDINFOSKINCOUNTFIELD.type = 5
var_0_2.PLAYERCARDINFOSKINCOUNTFIELD.cpp_type = 1
var_0_2.PLAYERCARDINFOTOWERLAYERFIELD.name = "towerLayer"
var_0_2.PLAYERCARDINFOTOWERLAYERFIELD.full_name = ".PlayerCardInfo.towerLayer"
var_0_2.PLAYERCARDINFOTOWERLAYERFIELD.number = 19
var_0_2.PLAYERCARDINFOTOWERLAYERFIELD.index = 18
var_0_2.PLAYERCARDINFOTOWERLAYERFIELD.label = 1
var_0_2.PLAYERCARDINFOTOWERLAYERFIELD.has_default_value = false
var_0_2.PLAYERCARDINFOTOWERLAYERFIELD.default_value = 0
var_0_2.PLAYERCARDINFOTOWERLAYERFIELD.type = 5
var_0_2.PLAYERCARDINFOTOWERLAYERFIELD.cpp_type = 1
var_0_2.PLAYERCARDINFOTOWERBOSSPASSCOUNTFIELD.name = "towerBossPassCount"
var_0_2.PLAYERCARDINFOTOWERBOSSPASSCOUNTFIELD.full_name = ".PlayerCardInfo.towerBossPassCount"
var_0_2.PLAYERCARDINFOTOWERBOSSPASSCOUNTFIELD.number = 20
var_0_2.PLAYERCARDINFOTOWERBOSSPASSCOUNTFIELD.index = 19
var_0_2.PLAYERCARDINFOTOWERBOSSPASSCOUNTFIELD.label = 1
var_0_2.PLAYERCARDINFOTOWERBOSSPASSCOUNTFIELD.has_default_value = false
var_0_2.PLAYERCARDINFOTOWERBOSSPASSCOUNTFIELD.default_value = 0
var_0_2.PLAYERCARDINFOTOWERBOSSPASSCOUNTFIELD.type = 5
var_0_2.PLAYERCARDINFOTOWERBOSSPASSCOUNTFIELD.cpp_type = 1
var_0_2.PLAYERCARDINFOHEROMAXLEVELCOUNTFIELD.name = "heroMaxLevelCount"
var_0_2.PLAYERCARDINFOHEROMAXLEVELCOUNTFIELD.full_name = ".PlayerCardInfo.heroMaxLevelCount"
var_0_2.PLAYERCARDINFOHEROMAXLEVELCOUNTFIELD.number = 21
var_0_2.PLAYERCARDINFOHEROMAXLEVELCOUNTFIELD.index = 20
var_0_2.PLAYERCARDINFOHEROMAXLEVELCOUNTFIELD.label = 1
var_0_2.PLAYERCARDINFOHEROMAXLEVELCOUNTFIELD.has_default_value = false
var_0_2.PLAYERCARDINFOHEROMAXLEVELCOUNTFIELD.default_value = 0
var_0_2.PLAYERCARDINFOHEROMAXLEVELCOUNTFIELD.type = 5
var_0_2.PLAYERCARDINFOHEROMAXLEVELCOUNTFIELD.cpp_type = 1
var_0_2.PLAYERCARDINFOWEEKWALKVER2PLATINUMCUPFIELD.name = "weekwalkVer2PlatinumCup"
var_0_2.PLAYERCARDINFOWEEKWALKVER2PLATINUMCUPFIELD.full_name = ".PlayerCardInfo.weekwalkVer2PlatinumCup"
var_0_2.PLAYERCARDINFOWEEKWALKVER2PLATINUMCUPFIELD.number = 22
var_0_2.PLAYERCARDINFOWEEKWALKVER2PLATINUMCUPFIELD.index = 21
var_0_2.PLAYERCARDINFOWEEKWALKVER2PLATINUMCUPFIELD.label = 1
var_0_2.PLAYERCARDINFOWEEKWALKVER2PLATINUMCUPFIELD.has_default_value = false
var_0_2.PLAYERCARDINFOWEEKWALKVER2PLATINUMCUPFIELD.default_value = 0
var_0_2.PLAYERCARDINFOWEEKWALKVER2PLATINUMCUPFIELD.type = 5
var_0_2.PLAYERCARDINFOWEEKWALKVER2PLATINUMCUPFIELD.cpp_type = 1
var_0_2.PLAYERCARDINFO_MSG.name = "PlayerCardInfo"
var_0_2.PLAYERCARDINFO_MSG.full_name = ".PlayerCardInfo"
var_0_2.PLAYERCARDINFO_MSG.nested_types = {}
var_0_2.PLAYERCARDINFO_MSG.enum_types = {}
var_0_2.PLAYERCARDINFO_MSG.fields = {
	var_0_2.PLAYERCARDINFOSHOWSETTINGSFIELD,
	var_0_2.PLAYERCARDINFOPROGRESSSETTINGFIELD,
	var_0_2.PLAYERCARDINFOBASESETTINGFIELD,
	var_0_2.PLAYERCARDINFOHEROCOVERFIELD,
	var_0_2.PLAYERCARDINFOTHEMEIDFIELD,
	var_0_2.PLAYERCARDINFOSHOWACHIEVEMENTFIELD,
	var_0_2.PLAYERCARDINFOCRITTERFIELD,
	var_0_2.PLAYERCARDINFOROOMCOLLECTIONFIELD,
	var_0_2.PLAYERCARDINFOWEEKWALKDEEPLAYERIDFIELD,
	var_0_2.PLAYERCARDINFOEXPLORECOLLECTIONFIELD,
	var_0_2.PLAYERCARDINFOROUGEDIFFICULTYFIELD,
	var_0_2.PLAYERCARDINFOACT128SSSCOUNTFIELD,
	var_0_2.PLAYERCARDINFOACHIEVEMENTCOUNTFIELD,
	var_0_2.PLAYERCARDINFOASSISTTIMESFIELD,
	var_0_2.PLAYERCARDINFOHEROCOVERTIMESFIELD,
	var_0_2.PLAYERCARDINFOMAXFAITHHEROCOUNTFIELD,
	var_0_2.PLAYERCARDINFOTOTALCOSTPOWERFIELD,
	var_0_2.PLAYERCARDINFOSKINCOUNTFIELD,
	var_0_2.PLAYERCARDINFOTOWERLAYERFIELD,
	var_0_2.PLAYERCARDINFOTOWERBOSSPASSCOUNTFIELD,
	var_0_2.PLAYERCARDINFOHEROMAXLEVELCOUNTFIELD,
	var_0_2.PLAYERCARDINFOWEEKWALKVER2PLATINUMCUPFIELD
}
var_0_2.PLAYERCARDINFO_MSG.is_extendable = false
var_0_2.PLAYERCARDINFO_MSG.extensions = {}
var_0_2.PlayerCardInfo = var_0_1.Message(var_0_2.PLAYERCARDINFO_MSG)
var_0_2.PlayerCloth = var_0_1.Message(var_0_2.PLAYERCLOTH_MSG)
var_0_2.PlayerClothInfo = var_0_1.Message(var_0_2.PLAYERCLOTHINFO_MSG)
var_0_2.PlayerInfo = var_0_1.Message(var_0_2.PLAYERINFO_MSG)
var_0_2.SimplePlayerInfo = var_0_1.Message(var_0_2.SIMPLEPLAYERINFO_MSG)

return var_0_2
