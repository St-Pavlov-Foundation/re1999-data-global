module("modules.logic.teach.view.TeachNoteDetailView", package.seeall)

local var_0_0 = class("TeachNoteDetailView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg2")
	arg_1_0._simagebg3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg3")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_icon")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#txt_name")
	arg_1_0._txtnameen = gohelper.findChildText(arg_1_0.viewGO, "#txt_nameen")
	arg_1_0._goitemdescs = gohelper.findChild(arg_1_0.viewGO, "#go_itemdescs")
	arg_1_0._godescitem = gohelper.findChild(arg_1_0.viewGO, "#go_itemdescs/#go_descitem")
	arg_1_0._gonotetip = gohelper.findChild(arg_1_0.viewGO, "#go_notetip")
	arg_1_0._txtnotedesc = gohelper.findChildText(arg_1_0.viewGO, "#go_notetip/#txt_notedesc")
	arg_1_0._btnlearn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_learn")
	arg_1_0._txtlearnstart = gohelper.findChildText(arg_1_0.viewGO, "#btn_learn/start")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnlearn:AddClickListener(arg_2_0._btnlearnOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnlearn:RemoveClickListener()
end

function var_0_0._btnlearnOnClick(arg_4_0)
	local var_4_0 = DungeonConfig.instance:getEpisodeCO(arg_4_0.viewParam)

	TeachNoteModel.instance:setTeachNoteEnterFight(true, true)
	DungeonFightController.instance:enterFight(var_4_0.chapterId, arg_4_0.viewParam)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._simagebg:LoadImage(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_5.png"))
	arg_5_0._simagebg2:LoadImage(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_5_1.png"))
	arg_5_0._simagebg3:LoadImage(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_5_2.png"))
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0._descItems = {}

	arg_7_0:_refreshView()
end

function var_0_0._refreshView(arg_8_0)
	local var_8_0 = DungeonConfig.instance:getEpisodeCO(arg_8_0.viewParam)

	arg_8_0._txtname.text = var_8_0.name
	arg_8_0._txtnameen.text = var_8_0.name_En

	local var_8_1 = TeachNoteModel.instance:getTeachNoteInstructionLevelCo(arg_8_0.viewParam)

	arg_8_0._simageicon:LoadImage(ResUrl.getTeachNoteImage(var_8_1.picRes .. ".png"))

	arg_8_0._txtnotedesc.text = var_8_1.instructionDesc

	if arg_8_0._descItems then
		for iter_8_0, iter_8_1 in pairs(arg_8_0._descItems) do
			iter_8_1:onDestroyView()
		end
	end

	arg_8_0._descItems = {}

	local var_8_2 = string.split(TeachNoteConfig.instance:getInstructionLevelCO(var_8_1.id).desc, "#")
	local var_8_3

	for iter_8_2 = 1, #var_8_2 do
		local var_8_4 = gohelper.cloneInPlace(arg_8_0._godescitem)

		gohelper.setActive(var_8_4, true)

		local var_8_5 = TeachNoteDescItem.New()

		var_8_5:init(var_8_4, iter_8_2, var_8_1.id)
		table.insert(arg_8_0._descItems, var_8_5)
	end

	arg_8_0._txtlearnstart.text = luaLang("teachnoteview_start")
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	if arg_10_0._descItems then
		for iter_10_0, iter_10_1 in pairs(arg_10_0._descItems) do
			iter_10_1:onDestroyView()
		end
	end

	arg_10_0._descItems = {}

	arg_10_0._simageicon:UnLoadImage()
	arg_10_0._simagebg:UnLoadImage()
	arg_10_0._simagebg2:UnLoadImage()
	arg_10_0._simagebg3:UnLoadImage()
end

return var_0_0
