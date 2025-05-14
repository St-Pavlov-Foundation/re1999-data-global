module("modules.logic.fight.view.FightTechniqueGuideView", package.seeall)

local var_0_0 = class("FightTechniqueGuideView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotargetframe = gohelper.findChild(arg_1_0.viewGO, "#go_targetframe")
	arg_1_0._goguidContent = gohelper.findChild(arg_1_0.viewGO, "#go_guidContent")
	arg_1_0._goguideitem = gohelper.findChild(arg_1_0.viewGO, "#go_guidContent/#go_guideitem")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateParam(arg_6_0)
	arg_6_0:refresh()
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:refresh()
end

function var_0_0.refresh(arg_8_0)
	TaskDispatcher.cancelTask(FightWorkFocusMonster.showCardPart, FightWorkFocusMonster)

	arg_8_0._entityMO = arg_8_0.viewParam.entity
	arg_8_0._config = arg_8_0.viewParam.config
	arg_8_0._is_enter_type = arg_8_0._config.invokeType == FightWorkFocusMonster.invokeType.Enter

	if arg_8_0._entityMO then
		FightMsgMgr.sendMsg(FightMsgId.CameraFocusChanged, true)
		FightWorkFocusMonster.focusCamera(arg_8_0._entityMO.id)
		FightController.instance:dispatchEvent(FightEvent.OnCameraFocusChanged, true)
	end

	arg_8_0._show_des = string.split(arg_8_0._config.des, "|")
	arg_8_0._show_icon = string.split(arg_8_0._config.icon, "|")
	arg_8_0._isActivityVersion = string.split(arg_8_0._config.isActivityVersion, "|")

	gohelper.CreateObjList(arg_8_0, arg_8_0._onItemShow, arg_8_0._show_des, arg_8_0._goguidContent, arg_8_0._goguideitem)
	FightHelper.setMonsterGuideFocusState(arg_8_0._config)
end

function var_0_0._onItemShow(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = arg_9_1.transform
	local var_9_1 = gohelper.findChildSingleImage(arg_9_1, "simage_guideicon")
	local var_9_2 = var_9_0:Find("img_desc/txt_desc"):GetComponent(gohelper.Type_TextMesh)
	local var_9_3 = var_9_0:Find("go_career").gameObject
	local var_9_4 = arg_9_0._show_des[arg_9_3]
	local var_9_5 = string.gsub(var_9_4, "%【", string.format("<color=%s>", "#F87D42"))

	var_9_2.text = string.gsub(var_9_5, "%】", "</color>")

	var_9_1:LoadImage(ResUrl.getFightTechniqueGuide(arg_9_0._show_icon[arg_9_3], arg_9_0._isActivityVersion[arg_9_3] == "1") or "")

	if not arg_9_0._images then
		arg_9_0._images = {}
	end

	table.insert(arg_9_0._images, var_9_1)

	local var_9_6 = gohelper.findChildImage(var_9_3, "image_bg")
	local var_9_7
	local var_9_8 = arg_9_0._entityMO and arg_9_0._entityMO.modelId or arg_9_0.viewParam.modelId

	if var_9_8 then
		local var_9_9 = lua_monster.configDict[var_9_8]

		var_9_7 = var_9_9 and var_9_9.career
	end

	local var_9_10

	if var_9_7 and var_9_7 ~= 5 and var_9_7 ~= 6 then
		var_9_10 = FightConfig.instance:restrainedBy(var_9_7)

		local var_9_11 = {
			"#473115",
			"#192c40",
			"#243829",
			"#4d2525",
			"#462b48",
			"#564d26"
		}

		SLFramework.UGUI.GuiHelper.SetColor(var_9_6, var_9_11[var_9_10])
		UISpriteSetMgr.instance:setCommonSprite(gohelper.findChildImage(var_9_3, "image_career"), "lssx_" .. var_9_10)
	end

	gohelper.setActive(var_9_3, var_9_10 and arg_9_3 == 1)
end

function var_0_0.onClose(arg_10_0)
	FightWorkFocusMonster.cancelFocusCamera()
end

function var_0_0.onDestroyView(arg_11_0)
	if arg_11_0._images then
		for iter_11_0, iter_11_1 in ipairs(arg_11_0._images) do
			iter_11_1:UnLoadImage()
		end
	end

	arg_11_0._images = nil
end

return var_0_0
