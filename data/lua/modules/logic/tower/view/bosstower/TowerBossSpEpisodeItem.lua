module("modules.logic.tower.view.bosstower.TowerBossSpEpisodeItem", package.seeall)

local var_0_0 = class("TowerBossSpEpisodeItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0.transform = arg_1_1.transform
	arg_1_0.goOpen = gohelper.findChild(arg_1_0.viewGO, "goOpen")
	arg_1_0.goUnopen = gohelper.findChild(arg_1_0.viewGO, "goUnopen")
	arg_1_0.goSelect1 = gohelper.findChild(arg_1_0.viewGO, "goOpen/goSelect")
	arg_1_0.goSelect2 = gohelper.findChild(arg_1_0.viewGO, "goOpen/goSelect2")
	arg_1_0.txtCurEpisode = gohelper.findChildTextMesh(arg_1_0.viewGO, "goOpen/txtCurEpisode")
	arg_1_0.goLock = gohelper.findChild(arg_1_0.viewGO, "goOpen/goLock")
	arg_1_0.goFinish = gohelper.findChild(arg_1_0.viewGO, "goOpen/goFinished")
	arg_1_0.animHasGet = gohelper.findChild(arg_1_0.viewGO, "goOpen/goFinished/go_hasget"):GetComponent(gohelper.Type_Animator)
	arg_1_0.btnClick = gohelper.findButtonWithAudio(arg_1_0.viewGO)
	arg_1_0.towerType = TowerEnum.TowerType.Boss
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnClick, arg_2_0._onBtnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0.btnClick)
end

function var_0_0._onBtnClick(arg_4_0)
	arg_4_0.parentView:onClickEpisode(arg_4_0.layerId)
end

function var_0_0.updateItem(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.parentView = arg_5_3
	arg_5_0.layerId = arg_5_1
	arg_5_0.index = arg_5_2

	if not arg_5_1 then
		gohelper.setActive(arg_5_0.goUnopen, true)
		gohelper.setActive(arg_5_0.goOpen, false)

		return
	end

	gohelper.setActive(arg_5_0.viewGO, true)

	local var_5_0 = arg_5_0.parentView.towerMo
	local var_5_1 = arg_5_0.parentView.episodeMo
	local var_5_2 = var_5_0:isSpLayerOpen(arg_5_0.layerId)

	gohelper.setActive(arg_5_0.goUnopen, not var_5_2)
	gohelper.setActive(arg_5_0.goOpen, var_5_2)

	if var_5_2 then
		arg_5_0.txtCurEpisode.text = tostring(arg_5_2)

		local var_5_3 = var_5_0:isLayerUnlock(arg_5_0.layerId, var_5_1)

		gohelper.setActive(arg_5_0.goLock, not var_5_3)
		arg_5_0:updateSelect()
	end

	arg_5_0.isPassLayer = var_5_0.passLayerId >= arg_5_0.layerId

	gohelper.setActive(arg_5_0.goFinish, arg_5_0.isPassLayer)
	arg_5_0:playFinishEffect()
end

function var_0_0.updateSelect(arg_6_0)
	if not arg_6_0.layerId then
		return
	end

	local var_6_0 = arg_6_0.parentView:isSelectEpisode(arg_6_0.layerId)

	gohelper.setActive(arg_6_0.goSelect1, var_6_0)
	gohelper.setActive(arg_6_0.goSelect2, var_6_0)

	local var_6_1 = var_6_0 and 1 or 0.85

	transformhelper.setLocalScale(arg_6_0.transform, var_6_1, var_6_1, 1)
end

function var_0_0.playFinishEffect(arg_7_0)
	local var_7_0 = TowerModel.instance:getTowerOpenInfo(arg_7_0.parentView.towerMo.type, arg_7_0.parentView.towerMo.towerId)

	if TowerModel.instance:getLocalPrefsState(TowerEnum.LocalPrefsKey.TowerBossSPEpisodeFinishEffect, arg_7_0.layerId, var_7_0, 0) == 0 and arg_7_0.isPassLayer then
		arg_7_0.animHasGet:Play("go_hasget_in", 0, 0)
		TowerModel.instance:setLocalPrefsState(TowerEnum.LocalPrefsKey.TowerBossSPEpisodeFinishEffect, arg_7_0.layerId, var_7_0, 1)
	else
		arg_7_0.animHasGet:Play("go_hasget_idle", 0, 0)
	end
end

function var_0_0.onDestroy(arg_8_0)
	return
end

return var_0_0
