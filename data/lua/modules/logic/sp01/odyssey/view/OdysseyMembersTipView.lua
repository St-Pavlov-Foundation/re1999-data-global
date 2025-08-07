module("modules.logic.sp01.odyssey.view.OdysseyMembersTipView", package.seeall)

local var_0_0 = class("OdysseyMembersTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._goroot = gohelper.findChild(arg_1_0.viewGO, "#go_root")
	arg_1_0._golevel = gohelper.findChild(arg_1_0.viewGO, "#go_root/Info/#go_level")
	arg_1_0._txtLevel = gohelper.findChildText(arg_1_0.viewGO, "#go_root/Info/#go_level/#txt_Level")
	arg_1_0._txtName = gohelper.findChildText(arg_1_0.viewGO, "#go_root/Info/name/#txt_Name")
	arg_1_0._txtType = gohelper.findChildText(arg_1_0.viewGO, "#go_root/Info/name/#txt_Type")
	arg_1_0._scrolldesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_root/#scroll_desc")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#go_root/#scroll_desc/Viewport/Content/#txt_desc")
	arg_1_0._godescEffect = gohelper.findChild(arg_1_0.viewGO, "#go_root/image_LightBG")
	arg_1_0._goclue = gohelper.findChild(arg_1_0.viewGO, "#go_root/#scroll_desc/Viewport/Content/#go_clue")
	arg_1_0._goclueContent = gohelper.findChild(arg_1_0.viewGO, "#go_root/#scroll_desc/Viewport/Content/#go_clue/#go_clueContent")
	arg_1_0._goclueItem = gohelper.findChild(arg_1_0.viewGO, "#go_root/#scroll_desc/Viewport/Content/#go_clue/#go_clueContent/#go_clueItem")
	arg_1_0._goitemRoot = gohelper.findChild(arg_1_0.viewGO, "#go_root/#scroll_desc/Viewport/Content/#go_itemRoot")
	arg_1_0._goitemContent = gohelper.findChild(arg_1_0.viewGO, "#go_root/#scroll_desc/Viewport/Content/#go_itemRoot/#go_itemContent")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "#go_root/#scroll_desc/Viewport/Content/#go_itemRoot/#go_itemContent/#go_item")
	arg_1_0._gorewardRoot = gohelper.findChild(arg_1_0.viewGO, "#go_root/#scroll_desc/Viewport/Content/#go_rewardRoot")
	arg_1_0._gorewardContent = gohelper.findChild(arg_1_0.viewGO, "#go_root/#scroll_desc/Viewport/Content/#go_rewardRoot/#go_rewardContent")
	arg_1_0._goreward = gohelper.findChild(arg_1_0.viewGO, "#go_root/#scroll_desc/Viewport/Content/#go_rewardRoot/#go_rewardContent/#go_reward")
	arg_1_0._goExposed = gohelper.findChild(arg_1_0.viewGO, "#go_root/#go_Exposed")
	arg_1_0._btncanExpose = gohelper.findChildClick(arg_1_0.viewGO, "#go_root/#go_Exposed/#btn_canExpose")
	arg_1_0._imageprogress = gohelper.findChildImage(arg_1_0.viewGO, "#go_root/#go_Exposed/#btn_canExpose/#image_progress")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "#go_root/#go_Exposed/#btn_canExpose/#go_reddot")
	arg_1_0._btngoto = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_root/#go_Exposed/#btn_goto")
	arg_1_0._godead = gohelper.findChild(arg_1_0.viewGO, "#go_root/#go_dead")
	arg_1_0._gounExposed = gohelper.findChild(arg_1_0.viewGO, "#go_root/#go_unExposed")
	arg_1_0._txtunExposed = gohelper.findChildText(arg_1_0.viewGO, "#go_root/#go_unExposed/#txt_unExposed")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btngoto:AddClickListener(arg_2_0._btngotoOnClick, arg_2_0)
	arg_2_0._btncanExpose:AddClickDownListener(arg_2_0.canExposeOnClickDown, arg_2_0)
	arg_2_0._btncanExpose:AddClickUpListener(arg_2_0.canExposeOnClickUp, arg_2_0)
	arg_2_0:addEventCb(OdysseyDungeonController.instance, OdysseyEvent.RefreshReligionMembers, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(OdysseyDungeonController.instance, OdysseyEvent.ShowExposeEffect, arg_2_0.showExposeEffect, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btngoto:RemoveClickListener()
	arg_3_0._btncanExpose:RemoveClickDownListener()
	arg_3_0._btncanExpose:RemoveClickUpListener()
	arg_3_0:removeEventCb(OdysseyDungeonController.instance, OdysseyEvent.RefreshReligionMembers, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(OdysseyDungeonController.instance, OdysseyEvent.ShowExposeEffect, arg_3_0.showExposeEffect, arg_3_0)
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btngotoOnClick(arg_5_0)
	OdysseyDungeonController.instance:jumpToMapElement(arg_5_0.fightElementCo.id)
	arg_5_0:closeThis()
	ViewMgr.instance:closeView(ViewName.OdysseyMembersView)
end

function var_0_0.canExposeOnClickDown(arg_6_0)
	if arg_6_0.religionMo then
		return
	end

	arg_6_0:cleanProgressTween()

	arg_6_0.progressTweenId = ZProj.TweenHelper.DOFillAmount(arg_6_0._imageprogress, 1, (1 - arg_6_0._imageprogress.fillAmount) * 2, arg_6_0.onExposeProgressFull, arg_6_0)

	AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_press)
end

function var_0_0.canExposeOnClickUp(arg_7_0)
	arg_7_0:cleanProgressTween()

	if arg_7_0._imageprogress.fillAmount >= 1 or arg_7_0.religionMo then
		return
	end

	arg_7_0.progressTweenId = ZProj.TweenHelper.DOFillAmount(arg_7_0._imageprogress, 0, arg_7_0._imageprogress.fillAmount * 2)
end

function var_0_0.onExposeProgressFull(arg_8_0)
	OdysseyRpc.instance:sendOdysseyFightReligionDiscloseRequest(arg_8_0.religionId)
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0.clueItemMap = arg_9_0:getUserDataTb_()
	arg_9_0.rewardItemMap = arg_9_0:getUserDataTb_()
	arg_9_0._imageprogress.fillAmount = 0

	gohelper.setActive(arg_9_0._godescEffect, false)
end

function var_0_0.onUpdateParam(arg_10_0)
	return
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0.religionCo = arg_11_0.viewParam.config
	arg_11_0.religionId = arg_11_0.religionCo.id
	arg_11_0.curMemberItemPos = arg_11_0.viewParam.pos

	arg_11_0:setViewPos()
	arg_11_0:refreshUI()
	OdysseyMembersModel.instance:setHasClickReglionId(arg_11_0.religionId)
end

var_0_0.TipHalfWidth = 434

function var_0_0.setViewPos(arg_12_0)
	local var_12_0 = recthelper.uiPosToScreenPos(arg_12_0.curMemberItemPos.transform)
	local var_12_1 = GameUtil.checkClickPositionInRight(var_12_0)
	local var_12_2, var_12_3 = recthelper.screenPosToAnchorPos2(var_12_0, arg_12_0.viewGO.transform)
	local var_12_4 = var_12_1 and var_12_2 - var_0_0.TipHalfWidth or var_12_2 + var_0_0.TipHalfWidth

	recthelper.setAnchorX(arg_12_0._goroot.transform, var_12_4)
end

function var_0_0.refreshUI(arg_13_0)
	arg_13_0.religionMo = OdysseyModel.instance:getReligionInfoData(arg_13_0.religionId)

	gohelper.setActive(arg_13_0._golevel, arg_13_0.religionMo)
	gohelper.setActive(arg_13_0._txtdesc.gameObject, arg_13_0.religionMo)

	arg_13_0.fightElementCo = OdysseyConfig.instance:getElementFightConfig(arg_13_0.religionCo.elementId)

	local var_13_0 = arg_13_0.fightElementCo and arg_13_0.fightElementCo.enemyLevel or 1
	local var_13_1 = OdysseyModel.instance:getHeroCurLevelAndExp()

	arg_13_0._txtLevel.text = var_13_1 < var_13_0 and string.format("<#E76969>%s</color>", var_13_0) or var_13_0
	arg_13_0._txtName.text = arg_13_0.religionMo and arg_13_0.religionCo.name or arg_13_0.religionCo.notExposeName
	arg_13_0._txtType.text = arg_13_0.religionCo.type
	arg_13_0._txtdesc.text = arg_13_0.religionCo.desc
	arg_13_0.canExpose = OdysseyMembersModel.instance:checkReligionMemberCanExpose(arg_13_0.religionId)

	gohelper.setActive(arg_13_0._gounExposed, not arg_13_0.canExpose)

	arg_13_0._txtunExposed.text = arg_13_0.religionCo.tips

	gohelper.setActive(arg_13_0._godead, arg_13_0.religionMo and arg_13_0.religionMo.status == OdysseyEnum.MemberStatus.Dead)
	gohelper.setActive(arg_13_0._goExposed, arg_13_0.canExpose)
	gohelper.setActive(arg_13_0._btncanExpose.gameObject, arg_13_0.canExpose and not arg_13_0.religionMo)
	gohelper.setActive(arg_13_0._goreddot, arg_13_0.canExpose and not arg_13_0.religionMo)
	gohelper.setActive(arg_13_0._btngoto.gameObject, arg_13_0.religionMo and arg_13_0.religionMo.status == OdysseyEnum.MemberStatus.Expose)
	gohelper.setActive(arg_13_0._goclue, not arg_13_0.religionMo)

	local var_13_2 = string.splitToNumber(arg_13_0.religionCo.clueList, "#")

	arg_13_0.newUnlockClueIdList = OdysseyMembersModel.instance:getNewClueIdList(arg_13_0.religionId)

	gohelper.CreateObjList(arg_13_0, arg_13_0.onClueShow, var_13_2, arg_13_0._goclueContent, arg_13_0._goclueItem)

	local var_13_3 = arg_13_0:getClueUnlockItem(var_13_2)

	gohelper.CreateObjList(arg_13_0, arg_13_0.onClueItemShow, var_13_3, arg_13_0._goitemContent, arg_13_0._goitem)
	gohelper.setActive(arg_13_0._goitemRoot, #var_13_3 > 0)

	local var_13_4 = arg_13_0.fightElementCo.reward

	gohelper.setActive(arg_13_0._gorewardRoot, not string.nilorempty(var_13_4))

	if not string.nilorempty(var_13_4) then
		local var_13_5 = GameUtil.splitString2(var_13_4)

		gohelper.CreateObjList(arg_13_0, arg_13_0.onRewardItemShow, var_13_5, arg_13_0._gorewardContent, arg_13_0._goreward)
	end
end

function var_0_0.onClueShow(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = arg_14_1:GetComponent(gohelper.Type_TextMesh)
	local var_14_1 = gohelper.findChild(arg_14_1, "go_unknown")
	local var_14_2 = gohelper.findChild(arg_14_1, "go_knowned")
	local var_14_3 = gohelper.findChild(arg_14_1, "image_LightBG")
	local var_14_4 = OdysseyConfig.instance:getReligionClueConfig(arg_14_2)
	local var_14_5 = var_14_4.unlockCondition
	local var_14_6 = OdysseyDungeonModel.instance:checkConditionCanUnlock(var_14_5)

	var_14_0.text = var_14_6 and string.format("<#B69B6F>%s</color>", var_14_4.clue) or luaLang("odyssey_religion_notexpose_clue")

	gohelper.setActive(var_14_1, not var_14_6)
	gohelper.setActive(var_14_2, var_14_6)
	gohelper.setActive(var_14_3, false)

	local var_14_7 = OdysseyMembersModel.instance:getHasClickReglionId(arg_14_0.religionId)
	local var_14_8 = tabletool.indexOf(arg_14_0.newUnlockClueIdList, arg_14_2)

	gohelper.setActive(var_14_3, var_14_8 and not var_14_7)
end

function var_0_0.onClueItemShow(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = arg_15_1
	local var_15_1 = arg_15_0.clueItemMap[arg_15_2.clueId]

	if not var_15_1 then
		var_15_1 = {
			itemGO = arg_15_0.viewContainer:getResInst(arg_15_0.viewContainer:getSetting().otherRes[1], var_15_0)
		}
		var_15_1.itemIcon = MonoHelper.addNoUpdateLuaComOnceToGo(var_15_1.itemGO, OdysseyItemIcon)
		arg_15_0.clueItemMap[arg_15_2.clueId] = var_15_1
	end

	var_15_1.itemIcon:initRewardItemInfo(arg_15_2.itemType, arg_15_2.itemId, arg_15_2.itemCount)
end

function var_0_0.getClueUnlockItem(arg_16_0, arg_16_1)
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		local var_16_1 = OdysseyConfig.instance:getReligionClueConfig(iter_16_1).unlockCondition

		if not string.nilorempty(var_16_1) then
			local var_16_2 = GameUtil.splitString2(var_16_1)

			for iter_16_2, iter_16_3 in ipairs(var_16_2) do
				if iter_16_3[1] == OdysseyEnum.ConditionType.Item and OdysseyItemModel.instance:getItemCount(tonumber(iter_16_3[2])) > 0 then
					table.insert(var_16_0, {
						clueId = iter_16_1,
						itemType = iter_16_3[1],
						itemId = tonumber(iter_16_3[2]),
						itemCount = tonumber(iter_16_3[3])
					})
				end
			end
		end
	end

	return var_16_0
end

function var_0_0.onRewardItemShow(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = arg_17_2[1]
	local var_17_1 = tonumber(arg_17_2[2])
	local var_17_2 = tonumber(arg_17_2[3])
	local var_17_3 = gohelper.findChild(arg_17_1, "go_pos")
	local var_17_4 = gohelper.findChild(arg_17_1, "go_get")
	local var_17_5 = arg_17_0.rewardItemMap[arg_17_3]

	if not var_17_5 then
		var_17_5 = {
			itemGO = arg_17_0.viewContainer:getResInst(arg_17_0.viewContainer:getSetting().otherRes[1], var_17_3)
		}
		var_17_5.itemIcon = MonoHelper.addNoUpdateLuaComOnceToGo(var_17_5.itemGO, OdysseyItemIcon)
		arg_17_0.rewardItemMap[arg_17_3] = var_17_5
	end

	var_17_5.itemIcon:initRewardItemInfo(var_17_0, var_17_1, var_17_2)
	gohelper.setActive(var_17_4, arg_17_0.religionMo and arg_17_0.religionMo.status == OdysseyEnum.MemberStatus.Dead)
end

function var_0_0.showExposeEffect(arg_18_0)
	gohelper.setActive(arg_18_0._godescEffect, false)
	gohelper.setActive(arg_18_0._godescEffect, true)
end

function var_0_0.cleanProgressTween(arg_19_0)
	if arg_19_0.progressTweenId then
		ZProj.TweenHelper.KillById(arg_19_0.progressTweenId)

		arg_19_0.progressTweenId = nil
	end
end

function var_0_0.onClose(arg_20_0)
	arg_20_0:cleanProgressTween()
end

function var_0_0.onDestroyView(arg_21_0)
	return
end

return var_0_0
