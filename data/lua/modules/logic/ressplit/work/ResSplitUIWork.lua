module("modules.logic.ressplit.work.ResSplitUIWork", package.seeall)

slot0 = class("ResSplitUIWork", BaseWork)

function slot0.onStart(slot0, slot1)
	slot2 = {
		"achievement",
		"activity",
		"backpack",
		"battlepass",
		"character",
		"common",
		"commonbufftipview",
		"currency",
		"dungeon",
		"effect",
		"equip",
		"enemyinfo",
		"fight",
		"gift",
		"guide",
		"handbook",
		"help",
		"herogroup",
		"login",
		"mail",
		"main",
		"messagebox",
		"notice",
		"player",
		"power",
		"room",
		"rpcblock",
		"scene",
		"sdk",
		"settings",
		"signin",
		"skin",
		"social",
		"store",
		"story",
		"storynavigate",
		"summon",
		"summonresultview",
		"task",
		"teach",
		"tips",
		"toast",
		"video",
		"turnback",
		"gm",
		"newwelfare",
		"headicon_",
		"headskinicon_",
		"signature",
		"loading",
		"message",
		"nickname",
		"propitem",
		"textures",
		"data_pic"
	}
	slot4 = {}
	slot5 = {}
	slot6 = {}

	for slot10, slot11 in ipairs({
		"",
		"/lang/common",
		"/lang/en",
		"/lang/jp",
		"/lang/kr",
		"/lang/tw",
		"/lang/zh"
	}) do
		slot12 = "Assets/ZResourcesLib" .. slot11 .. "/ui/viewres/"

		if SLFramework.FileHelper.IsDirExists(SLFramework.FrameworkSettings.AssetRootDir .. slot11 .. "/ui/viewres/") then
			for slot17 = 0, SLFramework.FileHelper.GetSubdirectories(SLFramework.FrameworkSettings.AssetRootDir .. slot11 .. "/ui/viewres/").Length - 1 do
				if not string.find(slot13[slot17], ".meta") then
					slot19 = false

					for slot23, slot24 in pairs(slot2) do
						if slot18 == slot12 .. slot24 then
							slot19 = true

							break
						end
					end

					if slot19 == false then
						table.insert(slot4, string.gsub(slot18, "Assets/ZResourcesLib/", "") .. "/")
					end
				end
			end
		end

		if SLFramework.FileHelper.IsDirExists(SLFramework.FrameworkSettings.AssetRootDir .. slot11 .. "/singlebg/") then
			slot12 = "Assets/ZResourcesLib" .. slot11 .. "/singlebg/"

			for slot17 = 0, SLFramework.FileHelper.GetSubdirectories(SLFramework.FrameworkSettings.AssetRootDir .. slot11 .. "/singlebg/").Length - 1 do
				if not string.find(slot13[slot17], ".meta") then
					slot19 = false

					for slot23, slot24 in pairs(slot2) do
						if string.find(slot18, slot12 .. slot24) then
							slot19 = true

							break
						end
					end

					if slot19 == false then
						table.insert(slot5, string.gsub(slot18, "Assets/ZResourcesLib/", "") .. "/")
					end
				end
			end
		end

		if SLFramework.FileHelper.IsDirExists(SLFramework.FrameworkSettings.AssetRootDir .. slot11 .. "/singlebg_lang/") then
			slot12 = "Assets/ZResourcesLib" .. slot11 .. "/singlebg_lang/"

			for slot17 = 0, SLFramework.FileHelper.GetSubdirectories(SLFramework.FrameworkSettings.AssetRootDir .. slot11 .. "/singlebg_lang/").Length - 1 do
				if not string.find(slot13[slot17], ".meta") then
					slot19 = false

					for slot23, slot24 in pairs(slot2) do
						if string.find(slot18, slot24) then
							slot19 = true

							break
						end
					end

					if slot19 == false then
						table.insert(slot6, string.gsub(slot18, "Assets/ZResourcesLib/", "") .. "/")
					end
				end
			end
		end
	end

	for slot10, slot11 in pairs(slot4) do
		ResSplitModel.instance:setExclude(ResSplitEnum.Folder, slot11, true)
	end

	for slot10, slot11 in pairs(slot5) do
		ResSplitModel.instance:setExclude(ResSplitEnum.SinglebgFolder, slot11, true)
		ResSplitModel.instance:setExclude(ResSplitEnum.Folder, slot11, true)
	end

	for slot10, slot11 in pairs(slot6) do
		ResSplitModel.instance:setExclude(ResSplitEnum.SinglebgFolder, slot11, true)
		ResSplitModel.instance:setExclude(ResSplitEnum.Folder, slot11, true)
	end

	slot0:onDone(true)
end

return slot0
