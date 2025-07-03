module("modules.logic.versionactivity2_3.newcultivationgift.view.VersionActivity2_3NewCultivationDetailView", package.seeall)

local var_0_0 = class("VersionActivity2_3NewCultivationDetailView", BaseView)

var_0_0.DISPLAY_TYPE = {
	Reward = 2,
	Effect = 1
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simagemask = gohelper.findChildSingleImage(arg_1_0.viewGO, "effect/#simage_mask")
	arg_1_0._goroleitemcontent = gohelper.findChild(arg_1_0.viewGO, "effect/#go_roleitemcontent")
	arg_1_0._goroleitem = gohelper.findChild(arg_1_0.viewGO, "effect/#go_roleitemcontent/#go_roleitem")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "effect/#go_roleitemcontent/#go_roleitem/#go_select")
	arg_1_0._scrolleffect = gohelper.findChildScrollRect(arg_1_0.viewGO, "effect/#scroll_effect")
	arg_1_0._godestinycontent = gohelper.findChild(arg_1_0.viewGO, "effect/#scroll_effect/Viewport/#go_destinycontent")
	arg_1_0._goeffectitem = gohelper.findChild(arg_1_0.viewGO, "effect/#scroll_effect/Viewport/#go_destinycontent/#go_effectitem")
	arg_1_0._imagestone = gohelper.findChildImage(arg_1_0.viewGO, "effect/#scroll_effect/Viewport/#go_destinycontent/#go_effectitem/#image_stone")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "effect/#scroll_effect/Viewport/#go_destinycontent/#go_effectitem/title/#txt_title")
	arg_1_0._godecitem = gohelper.findChild(arg_1_0.viewGO, "effect/#scroll_effect/Viewport/#go_destinycontent/#go_effectitem/#go_decitem")
	arg_1_0._txtdec = gohelper.findChildText(arg_1_0.viewGO, "effect/#scroll_effect/Viewport/#go_destinycontent/#go_effectitem/#go_decitem/#txt_dec")
	arg_1_0._scrollreward = gohelper.findChildScrollRect(arg_1_0.viewGO, "reward/#scroll_reward")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "reward/#scroll_reward/Viewport/#go_content")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "reward/#scroll_reward/Viewport/#go_content/#go_rewarditem")
	arg_1_0._btnclose = gohelper.findChildButton(arg_1_0.viewGO, "#btn_close")

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
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._goeffect = gohelper.findChild(arg_5_0.viewGO, "effect")
	arg_5_0._goreward = gohelper.findChild(arg_5_0.viewGO, "reward")
	arg_5_0._destinyEffectItemList = {}
	arg_5_0._rewardItemList = {}
	arg_5_0._roleItemList = {}
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	local var_7_0

	arg_7_0._showType, var_7_0 = arg_7_0.viewParam.showType, arg_7_0.viewParam.actId
	arg_7_0._needShowHeroIds = arg_7_0.viewParam.heroId or nil
	arg_7_0._actId = var_7_0

	arg_7_0:refreshUI()
end

function var_0_0.refreshUI(arg_8_0)
	local var_8_0 = arg_8_0._showType == arg_8_0.DISPLAY_TYPE.Effect
	local var_8_1 = arg_8_0._showType == arg_8_0.DISPLAY_TYPE.Reward

	if var_8_0 then
		arg_8_0:_refreshDestinyInfo()
	elseif var_8_1 then
		arg_8_0:_refreshReward()
	end

	gohelper.setActive(arg_8_0._goeffect, var_8_0)
	gohelper.setActive(arg_8_0._goreward, var_8_1)
end

function var_0_0._refreshReward(arg_9_0)
	local var_9_0 = Activity125Model.instance:getById(arg_9_0._actId)

	if var_9_0 == nil then
		return
	end

	local var_9_1 = var_9_0:getEpisodeList()

	if var_9_1 == nil or #var_9_1 <= 0 then
		return
	end

	local var_9_2 = var_9_1[1].id
	local var_9_3 = var_9_0.config[var_9_2].bonus

	if not string.nilorempty(var_9_3) then
		local var_9_4 = string.split(var_9_3, "|")
		local var_9_5 = #var_9_4
		local var_9_6 = #arg_9_0._rewardItemList

		for iter_9_0 = 1, var_9_5 do
			local var_9_7

			if iter_9_0 <= var_9_6 then
				var_9_7 = arg_9_0._rewardItemList[iter_9_0]
			else
				local var_9_8 = gohelper.clone(arg_9_0._gorewarditem, arg_9_0._gocontent)

				var_9_7 = MonoHelper.addNoUpdateLuaComOnceToGo(var_9_8, VersionActivity2_3NewCultivationRewardItem)

				table.insert(arg_9_0._rewardItemList, var_9_7)
			end

			local var_9_9 = var_9_4[iter_9_0]
			local var_9_10 = string.splitToNumber(var_9_9, "#")

			var_9_7:setEnable(true)
			var_9_7:onUpdateMO(var_9_10[1], var_9_10[2], var_9_10[3])
		end

		if var_9_5 < var_9_6 then
			for iter_9_1 = var_9_5 + 1, var_9_6 do
				arg_9_0._rewardItemList[iter_9_1]:setEnable(true)
			end
		end
	end
end

function var_0_0._refreshDestinyInfo(arg_10_0)
	arg_10_0:_refreshRoleInfo()
end

function var_0_0.onSelectRoleItem(arg_11_0, arg_11_1)
	if arg_11_0._roleId and arg_11_0._roleId == arg_11_1 then
		return
	end

	for iter_11_0, iter_11_1 in ipairs(arg_11_0._roleItemList) do
		iter_11_1:refreshSelect(arg_11_1)
	end

	arg_11_0._roleId = arg_11_1

	arg_11_0:_refreshEffectInfo(arg_11_1)
end

function var_0_0._refreshRoleInfo(arg_12_0)
	local var_12_0 = CharacterDestinyConfig.instance:getAllDestinyConfigList()

	if arg_12_0._needShowHeroIds ~= nil then
		local var_12_1 = {}

		for iter_12_0, iter_12_1 in ipairs(arg_12_0._needShowHeroIds) do
			for iter_12_2, iter_12_3 in ipairs(var_12_0) do
				if iter_12_3.heroId == iter_12_1 then
					table.insert(var_12_1, iter_12_3)
				end
			end
		end

		var_12_0 = var_12_1
	end

	local var_12_2 = #var_12_0

	if var_12_2 <= 0 then
		return
	end

	local var_12_3 = #arg_12_0._roleItemList

	for iter_12_4 = 1, var_12_2 do
		local var_12_4

		if var_12_3 < iter_12_4 then
			local var_12_5 = gohelper.clone(arg_12_0._goroleitem, arg_12_0._goroleitemcontent)

			gohelper.setActive(var_12_5, true)

			var_12_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_12_5, VersionActivity2_3NewCultivationRoleItem)

			var_12_4:init(var_12_5)
			table.insert(arg_12_0._roleItemList, var_12_4)
		else
			var_12_4 = arg_12_0._roleItemList[iter_12_4]
		end

		local var_12_6 = var_12_0[iter_12_4]

		var_12_4:setData(var_12_6)
		var_12_4:setClickCallBack(arg_12_0.onSelectRoleItem, arg_12_0)
	end

	local var_12_7 = var_12_0[1]

	arg_12_0:onSelectRoleItem(var_12_7.heroId)
end

function var_0_0._refreshEffectInfo(arg_13_0, arg_13_1)
	local var_13_0 = CharacterDestinyConfig.instance:getHeroDestiny(arg_13_1)

	if var_13_0 == nil then
		return
	end

	local var_13_1 = string.splitToNumber(var_13_0.facetsId, "#")

	if var_13_1 == nil then
		return
	end

	local var_13_2 = #var_13_1
	local var_13_3 = #arg_13_0._destinyEffectItemList

	for iter_13_0, iter_13_1 in ipairs(var_13_1) do
		local var_13_4

		if var_13_3 < iter_13_0 then
			local var_13_5 = gohelper.clone(arg_13_0._goeffectitem, arg_13_0._godestinycontent)

			var_13_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_13_5, VersionActivity2_3NewCultivationDestinyItem)

			table.insert(arg_13_0._destinyEffectItemList, var_13_4)
			var_13_4:init(var_13_5)
		else
			var_13_4 = arg_13_0._destinyEffectItemList[iter_13_0]
		end

		var_13_4:SetActive(true)
		var_13_4:setData(arg_13_1, iter_13_1)
	end

	if var_13_2 < var_13_3 then
		for iter_13_2 = var_13_2 + 1, var_13_3 do
			arg_13_0._destinyEffectItemList[iter_13_2]:SetActive(false)
		end
	end
end

function var_0_0.onClose(arg_14_0)
	return
end

function var_0_0.onDestroyView(arg_15_0)
	return
end

return var_0_0
