module("modules.logic.versionactivity2_5.act186.model.Activity186TaskListModel", package.seeall)

slot0 = class("Activity186TaskListModel", MixScrollModel)

function slot0.init(slot0, slot1)
	slot0._activityId = slot1
end

function slot0.refresh(slot0)
	if not Activity186Model.instance:getById(slot0._activityId) then
		return
	end

	slot3 = {}

	for slot7, slot8 in ipairs(slot1:getTaskList()) do
		if slot8.config then
			if not string.nilorempty(slot9.prepose) then
				slot10 = true

				for slot15, slot16 in ipairs(string.splitToNumber(slot9.prepose, "#")) do
					if not slot1:getTaskInfo(slot16) or not slot17.hasGetBonus then
						slot10 = false

						break
					end
				end

				if slot10 then
					table.insert(slot3, slot8)
				end
			else
				table.insert(slot3, slot8)
			end
		end
	end

	if #slot3 > 1 then
		table.sort(slot3, SortUtil.tableKeyLower({
			"status",
			"missionorder",
			"id"
		}))
	end

	for slot7, slot8 in ipairs(slot3) do
		slot8.index = slot7
	end

	slot0:setList(slot3)
end

slot0.instance = slot0.New()

return slot0
