module("modules.logic.survival.view.map.comp.SurvivalInitNPCItem", package.seeall)

local var_0_0 = class("SurvivalInitNPCItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._goHaveNpc = gohelper.findChild(arg_1_1, "#go_HaveHero")
	arg_1_0._goEmpty = gohelper.findChild(arg_1_1, "#go_Empty")
	arg_1_0._goLock = gohelper.findChild(arg_1_1, "#go_Locked")
	arg_1_0._goNew = gohelper.findChild(arg_1_1, "#go_New")
	arg_1_0._clickThis = gohelper.getClick(arg_1_1)
	arg_1_0._txtname = gohelper.findChildTextMesh(arg_1_0._goHaveNpc, "#txt_PartnerName")
	arg_1_0._imagechess = gohelper.findChildImage(arg_1_0._goHaveNpc, "#image_Chess")
	arg_1_0._goAttrItem = gohelper.findChild(arg_1_0._goHaveNpc, "Scroll View/Viewport/#go_content/#go_Attr")
end

function var_0_0.setIndex(arg_2_0, arg_2_1)
	arg_2_0._index = arg_2_1
end

function var_0_0.setParentView(arg_3_0, arg_3_1)
	arg_3_0._teamView = arg_3_1
end

function var_0_0.addEventListeners(arg_4_0)
	arg_4_0._clickThis:AddClickListener(arg_4_0._onClickThis, arg_4_0)
end

function var_0_0.removeEventListeners(arg_5_0)
	arg_5_0._clickThis:RemoveClickListener()
end

function var_0_0.getNpcMo(arg_6_0)
	return arg_6_0._npcMo
end

function var_0_0.setIsLock(arg_7_0, arg_7_1)
	arg_7_0._isLock = arg_7_1

	if arg_7_1 then
		gohelper.setActive(arg_7_0._goLock, true)
		gohelper.setActive(arg_7_0._goHaveNpc, false)
		gohelper.setActive(arg_7_0._goEmpty, false)
	end
end

function var_0_0.setNew(arg_8_0, arg_8_1)
	gohelper.setActive(arg_8_0._goNew, arg_8_1)
end

function var_0_0.onUpdateMO(arg_9_0, arg_9_1)
	arg_9_0._npcMo = arg_9_1

	local var_9_0 = arg_9_0._npcMo ~= nil

	gohelper.setActive(arg_9_0._goEmpty, not var_9_0)
	gohelper.setActive(arg_9_0._goHaveNpc, var_9_0)

	if var_9_0 then
		local var_9_1 = arg_9_1.co

		if not var_9_1 then
			return
		end

		arg_9_0._txtname.text = var_9_1.name

		UISpriteSetMgr.instance:setV2a2ChessSprite(arg_9_0._imagechess, var_9_1.headIcon, false)

		local var_9_2, var_9_3 = SurvivalConfig.instance:getNpcConfigTag(var_9_1.id)

		gohelper.CreateObjList(arg_9_0, arg_9_0._createTagItem, var_9_3, nil, arg_9_0._goAttrItem)
	end
end

function var_0_0._createTagItem(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = lua_survival_tag.configDict[arg_10_2]

	if not var_10_0 then
		return
	end

	local var_10_1 = gohelper.findChildTextMesh(arg_10_1, "image_TitleBG/#txt_Title")
	local var_10_2 = gohelper.findChildImage(arg_10_1, "image_TitleBG")
	local var_10_3 = gohelper.findChildTextMesh(arg_10_1, "")

	var_10_1.text = var_10_0.name
	var_10_3.text = var_10_0.desc

	UISpriteSetMgr.instance:setSurvivalSprite(var_10_2, "survivalpartnerteam_attrbg" .. var_10_0.color, false)
end

function var_0_0.showSelectEffect(arg_11_0)
	return
end

function var_0_0._onClickThis(arg_12_0)
	if arg_12_0._isLock then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Team_Open)
	ViewMgr.instance:openView(ViewName.SurvivalNPCSelectView, arg_12_0._npcMo)
end

function var_0_0.onDestroy(arg_13_0)
	arg_13_0._teamView = nil
end

return var_0_0
