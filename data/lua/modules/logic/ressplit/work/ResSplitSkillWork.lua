module("modules.logic.ressplit.work.ResSplitSkillWork", package.seeall)

slot0 = class("ResSplitSkillWork", BaseWork)
slot1 = {
	"FightTLEventTargetEffect",
	nil,
	nil,
	nil,
	"FightTLEventAtkEffect",
	"FightTLEventAtkFlyEffect",
	"FightTLEventAtkFullEffect",
	"FightTLEventDefEffect",
	[28.0] = "FightTLEventDefEffect"
}

function slot0.onStart(slot0, slot1)
	slot0.includeTimeLineDic = {}

	for slot6, slot7 in pairs(ResSplitModel.instance:getIncludeSkill()) do
		if lua_skill.configDict[slot6] then
			slot0.includeTimeLineDic[ResUrl.getSkillTimeline(slot8.timeline)] = true
		end
	end

	for slot7, slot8 in pairs(ResSplitModel.instance:getIncludeTimelineDic()) do
		slot0.includeTimeLineDic[ResUrl.getSkillTimeline(slot7)] = true
	end

	slot0._loader = MultiAbLoader.New()
	slot5 = {}

	for slot9 = 0, SLFramework.FileHelper.GetDirFilePaths("Assets/ZResourcesLib/rolestimeline").Length - 1 do
		if not string.find(slot4[slot9], ".meta") then
			slot0._loader:addPath(string.lower("rolestimeline/" .. SLFramework.FileHelper.GetFileName(slot10, true)))
		end
	end

	slot0._loader:startLoad(slot0._dealSkillTimeLine, slot0)
end

function slot0._dealSkillTimeLine(slot0)
	for slot4, slot5 in ipairs(slot0._loader._resList) do
		if not string.nilorempty(ZProj.SkillTimelineAssetHelper.GeAssetJson(slot5)) then
			for slot11 = 1, #cjson.decode(slot6), 2 do
				slot14 = slot7[slot11 + 1][1]

				if uv0[tonumber(slot7[slot11])] and not ResSplitHelper.checkConfigEmpty(string.format("SkillTimeLine:%s", slot5.ResPath), slot12, slot14) then
					slot15 = FightHelper.getEffectUrlWithLod(slot14)
					slot16 = ResSplitEnum.Folder
					slot17 = slot15

					if string.find(slot15, "effects/prefabs/buff/") or string.find(slot15, "effects/prefabs/story/") then
						slot16 = ResSplitEnum.Path
					else
						slot17 = string.gsub(slot15, "/" .. SLFramework.FileHelper.GetFileName(slot15, true), "")
					end

					if slot0.includeTimeLineDic[slot5.ResPath] then
						ResSplitModel.instance:setExclude(slot16, slot17, false)
					else
						ResSplitModel.instance:setExclude(slot16, slot17, true)
					end
				elseif slot12 == 16 and not ResSplitHelper.checkConfigEmpty(string.format("SkillTimeLine:%s", slot5.ResPath), slot12, slot14) then
					slot15 = ResUrl.getVideo(slot14)

					if slot0.includeTimeLineDic[slot5.ResPath] then
						ResSplitModel.instance:setExclude(ResSplitEnum.Video, slot14, false)
					else
						ResSplitModel.instance:setExclude(ResSplitEnum.Video, slot14, true)
					end
				end
			end
		end
	end

	slot0:onDone(true)
end

return slot0
