module("modules.logic.rouge.view.RougeTalentTreeBranchItem", package.seeall)

local var_0_0 = class("RougeTalentTreeBranchItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.viewGO = arg_1_1
end

function var_0_0.initcomp(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._config = arg_2_1
	arg_2_0._id = arg_2_1.id
	arg_2_0.isOrigin = arg_2_0._config.isOrigin == 1
	arg_2_0._parentIndex = arg_2_2
	arg_2_0._btnclick = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "#btn_click")
	arg_2_0._goselectframe = gohelper.findChild(arg_2_0.viewGO, "#go_selectframe")
	arg_2_0._imagetalenicon = gohelper.findChildImage(arg_2_0.viewGO, "#image_talenicon")
	arg_2_0._gotalentname = gohelper.findChild(arg_2_0.viewGO, "talenname")
	arg_2_0._txtprogress = gohelper.findChildText(arg_2_0.viewGO, "#txt_progress")
	arg_2_0._golocked = gohelper.findChild(arg_2_0.viewGO, "#go_locked")
	arg_2_0._goprogressunfull = gohelper.findChild(arg_2_0.viewGO, "#go_progress_unfull")
	arg_2_0._goprogressunfullLight = gohelper.findChild(arg_2_0.viewGO, "#go_progress_unfull/small_light")
	arg_2_0._imgprogress = gohelper.findChildImage(arg_2_0.viewGO, "#go_progress_unfull/circle")
	arg_2_0._goprogressfull = gohelper.findChild(arg_2_0.viewGO, "#go_progress_full")
	arg_2_0._goup = gohelper.findChild(arg_2_0.viewGO, "#go_up")
	arg_2_0._golight = gohelper.findChild(arg_2_0.viewGO, "#go_light")

	gohelper.setActive(arg_2_0._golight, false)

	arg_2_0._gocanselect = gohelper.findChild(arg_2_0.viewGO, "#go_canselect")
	arg_2_0._selectGO = gohelper.findChild(arg_2_0.viewGO, "#go_select")

	gohelper.setActive(arg_2_0._selectGO, true)

	arg_2_0._selectGOs = {}

	for iter_2_0 = 1, 3 do
		arg_2_0._selectGOs[iter_2_0] = gohelper.findChild(arg_2_0.viewGO, "#go_select/" .. iter_2_0)
	end

	arg_2_0._showAnim = false

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0._btnclick:AddClickListener(arg_3_0._btnclickOnClick, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_5_0)
	RougeController.instance:dispatchEvent(RougeEvent.OnClickTreeNode, arg_5_0._config)
	AudioMgr.instance:trigger(AudioEnum.UI.SelcetTalentItem)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0:addEvents()
end

function var_0_0.refreshItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0._config.cost == 1
	local var_7_1 = RougeTalentModel.instance:getUnlockNumByTalent(arg_7_0._parentIndex) / RougeTalentConfig.instance:getBranchNumByTalent(arg_7_0._parentIndex)
	local var_7_2 = var_7_1 >= 1

	arg_7_0._imgprogress.fillAmount = var_7_1

	gohelper.setActive(arg_7_0._goprogressunfull, not var_7_2 and arg_7_0.isOrigin)
	gohelper.setActive(arg_7_0._goprogressfull, var_7_2 and arg_7_0.isOrigin)

	local var_7_3 = RougeTalentModel.instance:checkNodeCanLevelUp(arg_7_0._config)

	gohelper.setActive(arg_7_0._gocanselect, var_7_3)

	if var_7_0 then
		transformhelper.setLocalScale(arg_7_0._golight.transform, 0.5, 0.5, 1)
	else
		transformhelper.setLocalScale(arg_7_0._golight.transform, 0.8, 0.8, 1)
	end

	if arg_7_2 and arg_7_2 == arg_7_0._config.id then
		gohelper.setActive(arg_7_0._golight, true)
		AudioMgr.instance:trigger(AudioEnum.UI.LightTalentItem)
	else
		gohelper.setActive(arg_7_0._golight, false)
	end

	local var_7_4 = RougeTalentModel.instance:checkNodeLock(arg_7_0._config)

	if var_7_3 and not arg_7_0.isOrigin then
		if var_7_0 then
			transformhelper.setLocalScale(arg_7_0._gocanselect.transform, 0.5, 0.5, 1)
		else
			transformhelper.setLocalScale(arg_7_0._gocanselect.transform, 0.8, 0.8, 1)
		end
	end

	gohelper.setActive(arg_7_0._gotalentname, false)
	gohelper.setActive(arg_7_0._txtprogress.gameObject, false)
	gohelper.setActive(arg_7_0._golocked, false)

	if not string.nilorempty(arg_7_0._config.icon) then
		if RougeTalentModel.instance:checkNodeLight(arg_7_0._config.id) then
			UISpriteSetMgr.instance:setRougeSprite(arg_7_0._imagetalenicon, arg_7_0._config.icon)
		else
			UISpriteSetMgr.instance:setRougeSprite(arg_7_0._imagetalenicon, arg_7_0._config.icon .. "_locked")
		end
	end

	gohelper.setActive(arg_7_0._goprogress, arg_7_0.isOrigin)

	local var_7_5 = not var_7_4 and not var_7_2
	local var_7_6 = RougeTalentModel.instance:getUnlockNumByTalent(arg_7_0._parentIndex) > 0

	gohelper.setActive(arg_7_0._goprogressunfullLight, var_7_5 and var_7_6 and arg_7_0.isOrigin)

	if arg_7_1 then
		local var_7_7 = 0
		local var_7_8 = arg_7_0.isOrigin and 3 or var_7_0 and 1 or 2

		gohelper.setActive(arg_7_0._selectGOs[var_7_8], true)
	else
		for iter_7_0, iter_7_1 in ipairs(arg_7_0._selectGOs) do
			gohelper.setActive(iter_7_1, false)
		end
	end
end

function var_0_0.getID(arg_8_0)
	return arg_8_0._id
end

function var_0_0.onDestroy(arg_9_0)
	return
end

function var_0_0.dispose(arg_10_0)
	arg_10_0:removeEvents()
	arg_10_0:__onDispose()
end

return var_0_0
