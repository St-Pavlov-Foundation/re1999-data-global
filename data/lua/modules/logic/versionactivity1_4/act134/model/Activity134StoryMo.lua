module("modules.logic.versionactivity1_4.act134.model.Activity134StoryMo", package.seeall)

slot0 = class("Activity134StoryMo")

function slot0.ctor(slot0)
	slot0.config = nil
	slot0.index = nil
	slot0.status = Activity134Enum.StroyStatus.Orgin
	slot0.title = nil
	slot0.desc = {}
	slot0.introduce = {}
	slot0.needTokensType = nil
	slot0.needTokensId = nil
	slot0.needTokensQuantity = nil
	slot0.icon = nil
end

function slot0.init(slot0, slot1, slot2)
	slot0.config = slot2
	slot0.index = slot1
	slot0.title = slot2.title
	slot0.storyType = slot2.storyType

	slot0:setDesc()

	slot3 = string.splitToNumber(slot2.needTokens, "#")
	slot0.needTokensType = slot3[1]
	slot0.needTokensId = slot3[2]
	slot0.needTokensQuantity = slot3[3]
end

function slot0.setDesc(slot0)
	if not slot0.config then
		return
	end

	for slot6, slot7 in ipairs(string.split(slot0.config.desc, "|")) do
		if not Activity134Config.instance:getStoryConfig(tonumber(slot7)) or slot8.storyType ~= slot0.storyType then
			logError("[1.4运营活动下半场尘封记录数据错误] 故事配置错误:" .. slot7)

			return
		end

		table.insert(slot0.desc, slot8)
	end
end

return slot0
