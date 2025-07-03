module("modules.logic.versionactivity2_7.v2a7_selfselectsix_1.view.V2a7_SelfSelectSix_PickChoiceItem", package.seeall)

local var_0_0 = class("V2a7_SelfSelectSix_PickChoiceItem", ListScrollCellExtend)

var_0_0.FirstDungeonId = 10101

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotitle = gohelper.findChild(arg_1_0.viewGO, "#go_title")
	arg_1_0._gooriginal = gohelper.findChild(arg_1_0.viewGO, "#go_title/#go_original")
	arg_1_0._golocked = gohelper.findChild(arg_1_0.viewGO, "#go_title/#go_locked")
	arg_1_0._txtlocked = gohelper.findChildText(arg_1_0.viewGO, "#go_title/#go_locked/#txt_locked")
	arg_1_0._gounlock = gohelper.findChild(arg_1_0.viewGO, "#go_title/#go_unlock")
	arg_1_0._txtunlock = gohelper.findChildText(arg_1_0.viewGO, "#go_title/#go_unlock/#txt_unlock")
	arg_1_0._gohero = gohelper.findChild(arg_1_0.viewGO, "#go_hero")
	arg_1_0._herocanvas = gohelper.onceAddComponent(arg_1_0._gohero, typeof(UnityEngine.CanvasGroup))
	arg_1_0._goheroitem = gohelper.findChild(arg_1_0.viewGO, "#go_hero/heroitem")
	arg_1_0._goexskill = gohelper.findChild(arg_1_0.viewGO, "#go_hero/heroitem/role/#go_exskill")
	arg_1_0._imageexskill = gohelper.findChildImage(arg_1_0.viewGO, "#go_hero/heroitem/role/#go_exskill/#image_exskill")
	arg_1_0._goclick = gohelper.findChild(arg_1_0.viewGO, "#go_hero/heroitem/select/#go_click")
	arg_1_0._itemList = {}

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(V2a7_SelfSelectSix_PickChoiceController.instance, V2a7_SelfSelectSix_PickChoiceEvent.onCustomPickListChanged, arg_2_0.refreshUI, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(V2a7_SelfSelectSix_PickChoiceController.instance, V2a7_SelfSelectSix_PickChoiceEvent.onCustomPickListChanged, arg_3_0.refreshUI, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._transcontent = arg_4_0._gohero.transform

	gohelper.setActive(arg_4_0._goheroitem, false)
end

function var_0_0._editableAddEvents(arg_5_0)
	return
end

function var_0_0._editableRemoveEvents(arg_6_0)
	return
end

function var_0_0.refreshUI(arg_7_0)
	if arg_7_0._isTitle then
		arg_7_0:_refreshTitle()
	else
		arg_7_0:_refreshHeroList()
	end

	arg_7_0._herocanvas.alpha = arg_7_0._mo.isUnlock and 1 or 0.5
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0._mo = arg_8_1
	arg_8_0._isTitle = arg_8_1.isTitle

	gohelper.setActive(arg_8_0._gotitle, arg_8_0._isTitle)
	gohelper.setActive(arg_8_0._gohero, not arg_8_0._isTitle)
	arg_8_0:refreshUI()
end

function var_0_0._refreshTitle(arg_9_0)
	if arg_9_0._mo.episodeId == var_0_0.FirstDungeonId then
		gohelper.setActive(arg_9_0._gooriginal, true)
		gohelper.setActive(arg_9_0._golocked, false)
		gohelper.setActive(arg_9_0._gounlock, false)
	else
		gohelper.setActive(arg_9_0._gooriginal, false)
		gohelper.setActive(arg_9_0._golocked, not arg_9_0._mo.isUnlock)
		gohelper.setActive(arg_9_0._gounlock, arg_9_0._mo.isUnlock)

		local var_9_0 = DungeonHelper.getEpisodeName(arg_9_0._mo.episodeId)

		arg_9_0._txtlocked.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("v2a7_newbie_storyprocess_locate_item"), var_9_0)
		arg_9_0._txtunlock.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("v2a7_newbie_storyprocess_locate_item_finish"), var_9_0)
	end
end

function var_0_0._refreshHeroList(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0._mo.heroIdList) do
		local var_10_0 = arg_10_0:getOrCreateItem(iter_10_0)
		local var_10_1 = SummonCustomPickChoiceMO.New()

		var_10_1:init(tonumber(iter_10_1))
		var_10_0.component:onUpdateMO(var_10_1)

		if not arg_10_0._mo.isUnlock then
			var_10_0.component:setLock()
		end
	end

	ZProj.UGUIHelper.RebuildLayout(arg_10_0._transcontent)
end

function var_0_0.getOrCreateItem(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._itemList[arg_11_1]

	if not var_11_0 then
		var_11_0 = arg_11_0:getUserDataTb_()
		var_11_0.go = gohelper.clone(arg_11_0._goheroitem, arg_11_0._gohero, "item" .. tostring(arg_11_1))

		gohelper.setActive(var_11_0.go, true)

		var_11_0.component = MonoHelper.addNoUpdateLuaComOnceToGo(var_11_0.go, V2a7_SelfSelectSix_PickChoiceHeroItem)

		var_11_0.component:init(var_11_0.go)
		var_11_0.component:addEvents()

		arg_11_0._itemList[arg_11_1] = var_11_0
	end

	return var_11_0
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
