module("modules.logic.tower.view.assistboss.TowerAssistBossView", package.seeall)

local var_0_0 = class("TowerAssistBossView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.txtTitle = gohelper.findChildTextMesh(arg_1_0.viewGO, "bg/txtTitle")
	arg_1_0.content = gohelper.findChild(arg_1_0.viewGO, "root/bosscontainer/Scroll/Viewport/Content")
	arg_1_0.gotips = gohelper.findChild(arg_1_0.viewGO, "title/tips")
	arg_1_0.txttips = gohelper.findChildTextMesh(arg_1_0.viewGO, "title/tips/txt_tips")
	arg_1_0.items = {}

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.TowerUpdate, arg_2_0.onTowerUpdate, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.RefreshTalent, arg_2_0.refreshView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.TowerUpdate, arg_3_0.onTowerUpdate, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.RefreshTalent, arg_3_0.refreshView, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0._onBtnStartClick(arg_5_0)
	return
end

function var_0_0.onTowerUpdate(arg_6_0)
	TowerAssistBossListModel.instance:initList()
	arg_6_0:refreshView()
end

function var_0_0.onUpdateParam(arg_7_0)
	arg_7_0:refreshParam()
	arg_7_0:refreshView()
end

function var_0_0.onOpen(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_mln_day_night)
	arg_8_0:refreshParam()
	arg_8_0:refreshView()
end

function var_0_0.refreshParam(arg_9_0)
	if arg_9_0.viewParam then
		arg_9_0.isFromHeroGroup = arg_9_0.viewParam.isFromHeroGroup
		arg_9_0.bossId = arg_9_0.viewParam.bossId
	end

	TowerAssistBossListModel.instance:initList()

	if arg_9_0.isFromHeroGroup then
		arg_9_0:addHeroGroupEvent()
	else
		arg_9_0:removeHeroGroupEvent()
	end
end

function var_0_0.refreshView(arg_10_0)
	TowerAssistBossListModel.instance:refreshList(arg_10_0.viewParam)

	local var_10_0 = TowerAssistBossListModel.instance:getList()
	local var_10_1 = #var_10_0
	local var_10_2 = #arg_10_0.items
	local var_10_3 = math.max(var_10_1, var_10_2)

	if var_10_1 <= 3 then
		arg_10_0.content.transform.pivot = Vector2(0.5, 1)
	else
		arg_10_0.content.transform.pivot = Vector2(0, 1)
	end

	for iter_10_0 = 1, var_10_3 do
		local var_10_4 = arg_10_0.items[iter_10_0]

		if not var_10_4 then
			local var_10_5 = arg_10_0.viewContainer:getSetting().otherRes.itemRes
			local var_10_6 = arg_10_0.viewContainer:getResInst(var_10_5, arg_10_0.content, tostring(iter_10_0))
			local var_10_7 = arg_10_0.viewParam.otherParam and arg_10_0.viewParam.otherParam.towerAssistBossItemCls or TowerAssistBossItem

			var_10_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_10_6, var_10_7)
			arg_10_0.items[iter_10_0] = var_10_4
		end

		local var_10_8 = var_10_0[iter_10_0]

		gohelper.setActive(var_10_4.viewGO, var_10_8 ~= nil)

		if var_10_8 then
			var_10_4:onUpdateMO(var_10_8, arg_10_0.viewParam)
		end
	end

	local var_10_9 = tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BalanceBossLevel))
	local var_10_10 = TowerModel.instance:getCurTowerType()

	gohelper.setActive(arg_10_0.gotips, var_10_10 == TowerEnum.TowerType.Limited)

	arg_10_0.txttips.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("towerassistbossviewtips"), var_10_9)
end

function var_0_0.addHeroGroupEvent(arg_11_0)
	if arg_11_0.hasAdd then
		return
	end

	arg_11_0.hasAdd = true

	arg_11_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, arg_11_0.refreshView, arg_11_0)
	arg_11_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_11_0.refreshView, arg_11_0)
	arg_11_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, arg_11_0.refreshView, arg_11_0)
	arg_11_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyGroupSelectIndex, arg_11_0.refreshView, arg_11_0)
end

function var_0_0.removeHeroGroupEvent(arg_12_0)
	if not arg_12_0.hasAdd then
		return
	end

	arg_12_0.hasAdd = false

	arg_12_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, arg_12_0.refreshView, arg_12_0)
	arg_12_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_12_0.refreshView, arg_12_0)
	arg_12_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, arg_12_0.refreshView, arg_12_0)
	arg_12_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyGroupSelectIndex, arg_12_0.refreshView, arg_12_0)
end

function var_0_0.onClose(arg_13_0)
	return
end

function var_0_0.onDestroyView(arg_14_0)
	return
end

return var_0_0
