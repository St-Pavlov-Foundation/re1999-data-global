module("modules.logic.sp01.odyssey.view.OdysseyMembersView", package.seeall)

local var_0_0 = class("OdysseyMembersView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gomembersItem = gohelper.findChild(arg_1_0.viewGO, "#go_membersItem")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0, LuaEventSystem.Low)
	arg_2_0:addEventCb(OdysseyDungeonController.instance, OdysseyEvent.RefreshReligionMembers, arg_2_0.createAndRefreshMember, arg_2_0)
	arg_2_0:addEventCb(OdysseyDungeonController.instance, OdysseyEvent.ShowExposeEffect, arg_2_0.showExposeEffect, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0, LuaEventSystem.Low)
	arg_3_0:removeEventCb(OdysseyDungeonController.instance, OdysseyEvent.RefreshReligionMembers, arg_3_0.createAndRefreshMember, arg_3_0)
	arg_3_0:removeEventCb(OdysseyDungeonController.instance, OdysseyEvent.ShowExposeEffect, arg_3_0.showExposeEffect, arg_3_0)
end

function var_0_0._btnMemberItemOnClick(arg_4_0, arg_4_1)
	if arg_4_0.curSelectMemberId == arg_4_1.config.id then
		return
	end

	arg_4_0.curSelectMemberId = arg_4_1.config.id

	OdysseyDungeonController.instance:openMembersTipView(arg_4_1)

	arg_4_0.hasClickReligionIdMap[arg_4_1.config.id] = arg_4_1.config.id

	arg_4_0:refreshSelectState()
	arg_4_0:refreshMemberItem(arg_4_1)
end

function var_0_0._editableInitView(arg_5_0)
	for iter_5_0 = 1, 13 do
		arg_5_0["_goMembers" .. iter_5_0] = gohelper.findChild(arg_5_0.viewGO, "Members/memberContent/#go_Members_" .. iter_5_0)
	end

	arg_5_0.memberItemMap = arg_5_0:getUserDataTb_()
	arg_5_0.hasClickReligionIdMap = arg_5_0:getUserDataTb_()

	gohelper.setActive(arg_5_0._gomembersItem, false)

	arg_5_0.curSelectMemberId = 0
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:createAndRefreshMember()
	arg_6_0:refreshSelectState()
	OdysseyStatHelper.instance:initViewStartTime()
end

function var_0_0.createAndRefreshMember(arg_7_0)
	local var_7_0 = OdysseyConfig.instance:getReligionConfigList()

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		local var_7_1 = arg_7_0.memberItemMap[iter_7_1.id]

		if not var_7_1 then
			var_7_1 = {
				config = iter_7_1,
				pos = arg_7_0["_goMembers" .. iter_7_1.pos]
			}
			var_7_1.itemGO = gohelper.clone(arg_7_0._gomembersItem, var_7_1.pos, "memberItem_" .. iter_7_1.id)
			var_7_1.gounExposed = gohelper.findChild(var_7_1.itemGO, "#go_unExposed")
			var_7_1.gocanExposed = gohelper.findChild(var_7_1.itemGO, "#go_unExposed/#go_canExposed")
			var_7_1.goUnExposedNormal = gohelper.findChild(var_7_1.itemGO, "#go_unExposed/#go_normal")
			var_7_1.goUnExposedBoss = gohelper.findChild(var_7_1.itemGO, "#go_unExposed/#go_boss")
			var_7_1.goExposed = gohelper.findChild(var_7_1.itemGO, "#go_Exposed")
			var_7_1.gonormal = gohelper.findChild(var_7_1.itemGO, "#go_Exposed/#go_normal")
			var_7_1.goboss = gohelper.findChild(var_7_1.itemGO, "#go_Exposed/#go_boss")
			var_7_1.simagenormalIcon = gohelper.findChildSingleImage(var_7_1.itemGO, "#go_Exposed/#go_normal/#image_normalIcon")
			var_7_1.simagebossIcon = gohelper.findChildSingleImage(var_7_1.itemGO, "#go_Exposed/#go_boss/#image_bossIcon")
			var_7_1.godead = gohelper.findChild(var_7_1.itemGO, "#go_Exposed/#go_dead")
			var_7_1.simagedeadIcon = gohelper.findChildSingleImage(var_7_1.itemGO, "#go_Exposed/#go_dead/#image_deadIcon")
			var_7_1.exposeEffect = gohelper.findChild(var_7_1.itemGO, "#go_Exposed/vx_glow")
			var_7_1.goselect = gohelper.findChild(var_7_1.itemGO, "#go_select")
			var_7_1.btnclick = gohelper.findChildButtonWithAudio(var_7_1.itemGO, "#btn_click")

			var_7_1.btnclick:AddClickListener(arg_7_0._btnMemberItemOnClick, arg_7_0, var_7_1)

			arg_7_0.memberItemMap[iter_7_1.id] = var_7_1
		end

		gohelper.setActive(var_7_1.itemGO, true)
		arg_7_0:refreshMemberItem(var_7_1)
	end
end

function var_0_0.refreshMemberItem(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.config
	local var_8_1 = OdysseyModel.instance:getReligionInfoData(var_8_0.id)
	local var_8_2 = OdysseyMembersModel.instance:checkReligionMemberCanExpose(var_8_0.id)
	local var_8_3 = OdysseyMembersModel.instance:getHasClickReglionId(var_8_0.id) or arg_8_0.hasClickReligionIdMap[var_8_0.id]
	local var_8_4 = OdysseyMembersModel.instance:checkHasNewClue(var_8_0.id)

	gohelper.setActive(arg_8_1.gounExposed, not var_8_1)
	gohelper.setActive(arg_8_1.gocanExposed, not var_8_1 and (var_8_2 or var_8_4 and not var_8_3))
	gohelper.setActive(arg_8_1.goUnExposedNormal, var_8_0.isBoss ~= 1)
	gohelper.setActive(arg_8_1.goUnExposedBoss, var_8_0.isBoss == 1)
	gohelper.setActive(arg_8_1.gonormal, var_8_0.isBoss ~= 1)
	gohelper.setActive(arg_8_1.goboss, var_8_0.isBoss == 1)
	gohelper.setActive(arg_8_1.goExposed, var_8_1)

	if var_8_1 then
		gohelper.setActive(arg_8_1.gonormal, var_8_0.isBoss ~= 1 and var_8_1.status == OdysseyEnum.MemberStatus.Expose)
		gohelper.setActive(arg_8_1.goboss, var_8_0.isBoss == 1 and var_8_1.status == OdysseyEnum.MemberStatus.Expose)
		gohelper.setActive(arg_8_1.godead, var_8_1.status == OdysseyEnum.MemberStatus.Dead)
		arg_8_1.simagenormalIcon:LoadImage(ResUrl.monsterHeadIcon(var_8_0.icon))
		arg_8_1.simagedeadIcon:LoadImage(ResUrl.monsterHeadIcon(var_8_0.icon))
		arg_8_1.simagebossIcon:LoadImage(ResUrl.monsterHeadIcon(var_8_0.icon))
	end
end

function var_0_0.refreshSelectState(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.memberItemMap) do
		gohelper.setActive(iter_9_1.goselect, iter_9_1.config.id == arg_9_0.curSelectMemberId)
	end
end

function var_0_0.showExposeEffect(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.memberItemMap[arg_10_1]
	local var_10_1 = OdysseyModel.instance:getReligionInfoData(arg_10_1)

	if var_10_0 and var_10_1 then
		gohelper.setActive(var_10_0.goExposed, true)
		gohelper.setActive(var_10_0.exposeEffect, false)
		gohelper.setActive(var_10_0.exposeEffect, true)
		AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_disclose)
	end
end

function var_0_0._onCloseView(arg_11_0, arg_11_1)
	if arg_11_1 == ViewName.OdysseyMembersTipView then
		arg_11_0.curSelectMemberId = 0

		arg_11_0:refreshSelectState()
	end
end

function var_0_0.onClose(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.memberItemMap) do
		iter_12_1.btnclick:RemoveClickListener()
		iter_12_1.simagenormalIcon:UnLoadImage()
		iter_12_1.simagedeadIcon:UnLoadImage()
		iter_12_1.simagebossIcon:UnLoadImage()
	end

	OdysseyMembersModel.instance:saveLocalNewClueUnlockState()
	OdysseyController.instance:dispatchEvent(OdysseyEvent.OnRefreshReddot)
	OdysseyStatHelper.instance:sendOdysseyViewStayTime("OdysseyMembersView")
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
