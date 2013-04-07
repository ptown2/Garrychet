local meta = FindMetaTable("Player")
if not meta then return end

function meta:GetLastAttacker()
	return self:GetDTEntity(0)
end

function meta:GetLastAttackerTime()
	return self:GetDTFloat(0)
end