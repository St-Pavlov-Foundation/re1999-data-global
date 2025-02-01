module("modules.logic.versionactivity1_5.aizila.helper.AiZiLaHelper", package.seeall)

return {
	getLimitTimeStr = function ()
		if ActivityModel.instance:getActMO(VersionActivity1_5Enum.ActivityId.AiZiLa) then
			return string.format(luaLang("versionactivity_remain_day"), slot0:getRemainTimeStr3())
		end

		return ""
	end,
	isOpenDay = function (slot0)
		slot1 = VersionActivity1_5Enum.ActivityId.AiZiLa
		slot3 = AiZiLaConfig.instance:getEpisodeCo(slot1, slot0)

		if ActivityModel.instance:getActMO(slot1) and slot3 then
			slot8 = math.max(slot2:getRealStartTimeStamp() + ((slot3.openDay or 0) - 1) * 24 * 60 * 60 - ServerTime.now(), 0)

			if slot3.preEpisode ~= 0 and not AiZiLaModel.instance:isEpisodeClear(slot3.preEpisode) or slot8 > 0 then
				return false, slot8
			end
		else
			if not slot3 then
				logNormal(string.format("can not find v1a5 activity episodeCfg. actId:%s episodeId:%s", slot1, slot0))
			end

			return false, -1
		end

		return true
	end,
	showToastByEpsodeId = function (slot0)
		if not AiZiLaConfig.instance:getEpisodeCo(VersionActivity1_5Enum.ActivityId.AiZiLa, slot0) then
			logNormal(string.format("can not find v1a5 activity episodeCfg. actId:%s episodeId:%s", VersionActivity1_5Enum.ActivityId.AiZiLa, slot0))

			return
		end

		slot3, slot4 = uv0.isOpenDay(slot2.id)

		if not slot3 then
			if slot2.preEpisode ~= 0 or not AiZiLaModel.instance:isEpisodeClear(slot2.preEpisode) then
				GameFacade.showToast(ToastEnum.V1a5AiZiLaEpisodeNotOpen, slot2.unlockDesc)
			else
				GameFacade.showToast(ToastEnum.Va3Act120EpisodeNotOpenTime)
			end
		end
	end,
	clearOrCreateModel = function (slot0)
		if slot0 then
			slot0:clear()
		else
			slot0 = BaseModel.New()
		end

		return slot0
	end,
	updateMOModel = function (slot0, slot1, slot2, slot3)
		if slot1:getById(slot2) == nil then
			slot4 = slot0.New()

			slot4:init(slot2)
			slot1:addAtLast(slot4)
		end

		slot4:updateInfo(slot3)

		return slot4
	end,
	getCostParams = function (slot0)
		slot1 = {}

		if slot0 and GameUtil.splitString2(slot0.cost, true) then
			for slot6, slot7 in ipairs(slot2) do
				table.insert(slot1, {
					itemId = slot7[1],
					itemNum = slot7[2]
				})
			end
		end

		return slot1
	end,
	checkCostParams = function (slot0)
		if slot0 then
			slot1 = AiZiLaModel.instance

			for slot5, slot6 in ipairs(slot0) do
				if slot1:getItemQuantity(slot6.itemId) < slot6.itemNum then
					return false
				end
			end
		end

		return true
	end,
	getEpisodeReward = function (slot0)
		slot1 = {}

		if not string.nilorempty(slot0) and string.splitToNumber(slot0, "|") then
			for slot6, slot7 in ipairs(slot2) do
				table.insert(slot1, {
					itemId = slot7
				})
			end
		end

		return slot1
	end,
	playViewAnimator = function (slot0, slot1)
		if ViewMgr.instance:getContainer(slot0) and slot2.playViewAnimator then
			slot2:playViewAnimator(slot1)
		end
	end,
	getItemMOListByBonusStr = function (slot0, slot1)
		if string.nilorempty(slot0) then
			return slot1
		end

		if GameUtil.splitString2(slot0, true) then
			for slot6, slot7 in ipairs(slot2) do
				slot8 = AiZiLaItemMO.New()

				slot8:init(slot7[1], slot7[1], slot7[2] or 1)
				table.insert(slot1 or {}, slot8)
			end
		end

		return slot1
	end,
	startBlock = function (slot0)
		if not UIBlockMgr.instance:isKeyBlock(slot0) then
			UIBlockMgr.instance:startBlock(slot0)
		end
	end,
	endBlock = function (slot0)
		if UIBlockMgr.instance:isKeyBlock(slot0) then
			UIBlockMgr.instance:endBlock(slot0)
		end
	end,
	isFinishRed = function (slot0)
		return PlayerPrefsHelper.getNumber(slot0, 0) == 1
	end,
	finishRed = function (slot0)
		PlayerPrefsHelper.setNumber(slot0, 1)
	end,
	getRedKey = function (slot0, slot1)
		return string.format("AiZiLaModel_red_skey_%s_%s_%s", PlayerModel.instance:getMyUserId() or 0, slot0, slot1 or 0)
	end
}
