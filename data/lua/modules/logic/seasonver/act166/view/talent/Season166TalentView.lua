module("modules.logic.seasonver.act166.view.talent.Season166TalentView", package.seeall)

local var_0_0 = class("Season166TalentView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0)
	arg_2_0:addEventCb(Season166Controller.instance, Season166Event.SetTalentSkill, arg_2_0._refreshTalentSlot, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
	arg_3_0:addEventCb(Season166Controller.instance, Season166Event.SetTalentSkill, arg_3_0._refreshTalentSlot, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._actId = Season166Model.instance:getCurSeasonId()

	arg_4_0:_initTalent()
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0.actId = Season166Model.instance:getCurSeasonId()

	arg_6_0:_refreshUI()
	arg_6_0:refreshReddot()
end

function var_0_0._initTalent(arg_7_0)
	local var_7_0 = {}
	local var_7_1 = lua_activity166_talent.configList

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		if iter_7_1.activityId == arg_7_0._actId then
			var_7_0[#var_7_0 + 1] = iter_7_1
		end
	end

	arg_7_0.talentItemDic = {}

	for iter_7_2 = 1, #var_7_0 do
		local var_7_2 = gohelper.findChild(arg_7_0.viewGO, "root/talents/talent" .. iter_7_2)

		if not gohelper.isNil(var_7_2) then
			local var_7_3 = arg_7_0:getUserDataTb_()

			var_7_3.config = var_7_0[iter_7_2]

			local var_7_4 = var_7_3.config.talentId
			local var_7_5 = gohelper.findChildButtonWithAudio(var_7_2, "up")

			gohelper.findChildText(var_7_2, "up/txt_talentName").text = var_7_3.config.name
			gohelper.findChildText(var_7_2, "up/en").text = var_7_3.config.nameEn
			var_7_3.goEquip = gohelper.findChild(var_7_2, "go_Equip")
			var_7_3.btnEquip = gohelper.findChildButtonWithAudio(var_7_2, "go_Equip/btn_equip")
			var_7_3.btnLock = gohelper.findChildButtonWithAudio(var_7_2, "go_Equip/locked")
			var_7_3.goequiping = gohelper.findChild(var_7_2, "go_Equip/go_equiping")
			var_7_3.reddotGO = gohelper.findChild(var_7_2, "reddot")
			var_7_3.goslot1 = gohelper.findChild(var_7_2, "equipslot/1")
			var_7_3.goslotLight1 = gohelper.findChild(var_7_2, "equipslot/1/light")
			var_7_3.goslot2 = gohelper.findChild(var_7_2, "equipslot/2")
			var_7_3.goslotLight2 = gohelper.findChild(var_7_2, "equipslot/2/light")
			var_7_3.goslot3 = gohelper.findChild(var_7_2, "equipslot/3")
			var_7_3.goslotLight3 = gohelper.findChild(var_7_2, "equipslot/3/light")
			var_7_3.anim = var_7_2:GetComponent(gohelper.Type_Animator)

			arg_7_0:addClickCb(var_7_5, arg_7_0._clickTalent, arg_7_0, var_7_4)
			arg_7_0:addClickCb(var_7_3.btnEquip, arg_7_0._clickEquip, arg_7_0, var_7_4)
			arg_7_0:addClickCb(var_7_3.btnLock, arg_7_0._clickLock, arg_7_0)

			arg_7_0.talentItemDic[var_7_4] = var_7_3
		end
	end
end

function var_0_0._clickTalent(arg_8_0, arg_8_1)
	ViewMgr.instance:openView(ViewName.Season166TalentSelectView, {
		talentId = arg_8_1
	})
end

function var_0_0._clickEquip(arg_9_0, arg_9_1)
	if Season166Model.getPrefsTalent() == arg_9_1 then
		return
	end

	Season166Model.setPrefsTalent(arg_9_1)
	Season166Controller.instance:dispatchEvent(Season166Event.SetTalentId, arg_9_1)
	arg_9_0:_refreshEquipBtn()
end

function var_0_0._clickLock(arg_10_0)
	GameFacade.showToast(ToastEnum.Season166TalentLock)
end

function var_0_0._refreshUI(arg_11_0)
	arg_11_0:_refreshTalentSlot()

	local var_11_0 = arg_11_0.viewParam and arg_11_0.viewParam.showEquip

	if var_11_0 then
		arg_11_0:_refreshEquipBtn()
	end

	for iter_11_0, iter_11_1 in pairs(arg_11_0.talentItemDic) do
		gohelper.setActive(iter_11_1.goEquip, var_11_0)
	end
end

function var_0_0._refreshEquipBtn(arg_12_0)
	local var_12_0 = arg_12_0.viewParam.talentId or Season166Model.getPrefsTalent()

	for iter_12_0, iter_12_1 in pairs(arg_12_0.talentItemDic) do
		if arg_12_0.viewParam.talentId then
			gohelper.setActive(iter_12_1.btnEquip, false)
			gohelper.setActive(iter_12_1.goequiping, iter_12_0 == var_12_0)
			gohelper.setActive(iter_12_1.btnLock, iter_12_0 ~= var_12_0)
		else
			gohelper.setActive(iter_12_1.btnEquip, iter_12_0 ~= var_12_0)
			gohelper.setActive(iter_12_1.goequiping, iter_12_0 == var_12_0)
			gohelper.setActive(iter_12_1.btnLock, false)
		end

		local var_12_1 = iter_12_0 == var_12_0 and "start" or "idle"

		iter_12_1.anim:Play(var_12_1)
	end
end

function var_0_0._refreshTalentSlot(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.talentItemDic) do
		local var_13_0 = Season166Model.instance:getTalentInfo(arg_13_0.actId, iter_13_0)
		local var_13_1 = var_13_0.config.slot
		local var_13_2 = var_13_0.skillIds

		for iter_13_2 = 1, 3 do
			local var_13_3 = "goslot" .. iter_13_2

			gohelper.setActive(iter_13_1[var_13_3], iter_13_2 <= var_13_1)

			if iter_13_2 <= var_13_1 then
				local var_13_4 = "goslotLight" .. iter_13_2

				gohelper.setActive(iter_13_1[var_13_4], iter_13_2 <= #var_13_2)
			end
		end
	end
end

function var_0_0.refreshReddot(arg_14_0)
	local var_14_0 = lua_activity166_talent.configDict[arg_14_0._actId]

	for iter_14_0, iter_14_1 in pairs(var_14_0) do
		local var_14_1 = arg_14_0.talentItemDic[iter_14_1.talentId].reddotGO

		gohelper.setActive(var_14_1, Season166Model.instance:checkHasNewTalent(iter_14_1.talentId))
	end
end

function var_0_0.checkTalentReddotShow(arg_15_0, arg_15_1)
	arg_15_1:defaultRefreshDot()

	local var_15_0 = arg_15_1.infoDict[RedDotEnum.DotNode.Season166Talent]

	arg_15_1.show = Season166Model.instance:checkHasNewTalent(var_15_0)

	if arg_15_1.show then
		arg_15_1:showRedDot(RedDotEnum.Style.Green)
	end
end

function var_0_0._onCloseView(arg_16_0, arg_16_1)
	if arg_16_1 == ViewName.Season166TalentSelectView then
		arg_16_0:refreshReddot()
	end
end

return var_0_0
