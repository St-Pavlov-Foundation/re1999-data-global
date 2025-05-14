module("modules.logic.room.view.critter.detail.RoomCritterDetailSkillItem", package.seeall)

local var_0_0 = class("RoomCritterDetailSkillItem", LuaCompBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtskillname = gohelper.findChildText(arg_1_0.viewGO, "title/#txt_skillname")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "title/#txt_skillname/#image_icon")
	arg_1_0._txtskilldec = gohelper.findChildText(arg_1_0.viewGO, "#txt_skilldec")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.init(arg_4_0, arg_4_1)
	arg_4_0.viewGO = arg_4_1

	arg_4_0:onInitView()
end

function var_0_0.addEventListeners(arg_5_0)
	arg_5_0:addEvents()
end

function var_0_0.removeEventListeners(arg_6_0)
	arg_6_0:removeEvents()
end

function var_0_0._editableInitView(arg_7_0)
	return
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	return
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

function var_0_0.onRefreshMo(arg_12_0, arg_12_1)
	arg_12_0._txtskillname.text = arg_12_1 and arg_12_1.name
	arg_12_0._txtskilldec.text = arg_12_1 and arg_12_1.desc

	if arg_12_0._imageicon and not string.nilorempty(arg_12_1.skillIcon) then
		UISpriteSetMgr.instance:setCritterSprite(arg_12_0._imageicon, arg_12_1.skillIcon)
	end
end

return var_0_0
