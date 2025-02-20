module("modules.logic.reddot.model.RedDotModel", package.seeall)

slot0 = class("RedDotModel", BaseModel)

function slot0.onInit(slot0)
	slot0._dotInfos = {}
	slot0._dotTree = {}
	slot0._latestExpireTime = 0
end

function slot0.reInit(slot0)
	slot0._dotInfos = {}
	slot0._dotTree = {}
end

function slot0._setDotTree(slot0)
	for slot5, slot6 in pairs(RedDotConfig.instance:getRedDotsCO()) do
		for slot11, slot12 in pairs(string.splitToNumber(slot6.parent, "#")) do
			if not slot0._dotTree[slot12] then
				slot0._dotTree[slot12] = {}
			end

			if not tabletool.indexOf(slot0._dotTree[slot12], slot6.id) then
				table.insert(slot0._dotTree[slot12], slot6.id)
			end
		end
	end
end

function slot0.setRedDotInfo(slot0, slot1)
	slot0:_setDotTree()

	slot6 = SocialMessageModel.instance:getMessageUnreadRedDotGroup()

	table.insert(slot1, slot6)

	slot0._latestExpireTime = 0

	for slot6, slot7 in ipairs(slot1) do
		slot8 = RedDotGroupMo.New()

		slot8:init(slot7)

		slot0._dotInfos[tonumber(slot7.defineId)] = slot8
	end

	slot0:_recountLastestExpireTime()
end

function slot0.updateRedDotInfo(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if not slot0._dotInfos[tonumber(slot6.defineId)] then
			slot7 = RedDotGroupMo.New()

			slot7:init(slot6)

			slot0._dotInfos[tonumber(slot6.defineId)] = slot7
		else
			slot0._dotInfos[tonumber(slot6.defineId)]:_resetDotInfo(slot6)
		end
	end

	slot0:_recountLastestExpireTime()
end

function slot0._recountLastestExpireTime(slot0)
	slot0._latestExpireTime = 0

	for slot4, slot5 in pairs(slot0._dotInfos) do
		for slot9, slot10 in pairs(slot5.infos) do
			if slot10.time > 0 and ServerTime.now() < slot10.time then
				if slot0._latestExpireTime > 0 then
					slot0._latestExpireTime = slot10.time < slot0._latestExpireTime and slot10.time or slot0._latestExpireTime
				else
					slot0._latestExpireTime = slot10.time
				end
			end
		end
	end
end

function slot0.getLatestExpireTime(slot0)
	return slot0._latestExpireTime
end

function slot0.getRedDotInfo(slot0, slot1)
	return slot0._dotInfos[slot1]
end

function slot0._getAssociateRedDots(slot0, slot1)
	table.insert({}, slot1)

	if #slot0:getDotParents(slot1) > 0 then
		function (slot0)
			for slot5, slot6 in pairs(uv0:getDotParents(slot0)) do
				table.insert(uv1, slot6)
				uv2(slot6)
			end
		end(slot1)
	end

	return slot2
end

function slot0.getDotParents(slot0, slot1)
	if not RedDotConfig.instance:getRedDotCO(slot1) or slot2.parent == "" then
		return {}
	end

	return string.splitToNumber(slot2.parent, "#")
end

function slot0.getDotChilds(slot0, slot1)
	function (slot0)
		if not uv0._dotTree[slot0] or #uv0._dotTree[slot0] == 0 then
			if not tabletool.indexOf(uv1, slot0) then
				table.insert(uv1, slot0)
			end
		else
			for slot4, slot5 in pairs(uv0._dotTree[slot0]) do
				if not uv0._dotTree[slot5] or #uv0._dotTree[slot5] == 0 then
					if not tabletool.indexOf(uv1, slot5) then
						table.insert(uv1, slot5)
					end
				else
					uv2(slot5)
				end
			end
		end
	end(slot1)

	return {}
end

function slot0.isDotShow(slot0, slot1, slot2)
	if not slot0._dotInfos[slot1] then
		for slot7, slot8 in pairs(slot0:getDotChilds(slot1)) do
			if slot0._dotInfos[slot8] then
				for slot12, slot13 in pairs(slot0._dotInfos[slot8].infos) do
					if slot13.value > 0 then
						return true
					end
				end
			end
		end

		return false
	elseif slot0._dotInfos[slot1].infos[slot2] then
		for slot6, slot7 in pairs(slot0._dotInfos[slot1].infos) do
			if slot7.uid == slot2 then
				return slot7.value > 0
			end
		end

		return false
	else
		if not slot0._dotInfos[slot1].infos[slot2] then
			return false
		end

		return slot0._dotInfos[slot1].infos[slot2].value > 0
	end

	return false
end

function slot0.getDotInfo(slot0, slot1, slot2)
	if slot0._dotInfos[slot1] then
		if slot0._dotInfos[slot1][slot2] then
			return slot0._dotInfos[slot1][slot2]
		else
			return slot0._dotInfos[slot1]
		end
	end

	return nil
end

function slot0.getDotInfoCount(slot0, slot1, slot2)
	if not slot2 or not slot0._dotInfos[slot1] or not slot0._dotInfos[slot1].infos[slot2] then
		return 0
	end

	return slot0._dotInfos[slot1].infos[slot2].value
end

slot0.instance = slot0.New()

return slot0
