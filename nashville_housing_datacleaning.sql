--Cleaning Data in SQL 
-- Nashville Housing Data
--Standardize the date 
SELECT SaleDate, CONVERT(Date, SaleDate)
FROM first_portfolio_project

Update first_portfolio_project
SET SaleDate = CONVERT(Date, SaleDate)
-- this code did not successfully convert the date

ALTER TABLE first_portfolio_project
Add SaleDateConverted Date;
Update first_portfolio_project
SET SaleDateConverted = CONVERT(Date, SaleDate)
--this was used instead

--Populate Property Address Data
SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM first_portfolio_project a
JOIN first_portfolio_project b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] != b.[UniqueID ]
WHERE a.PropertyAddress is null
 
 Update a
 SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
 FROM first_portfolio_project a
 JOIN first_portfolio_project b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] != b.[UniqueID ]
Where a.PropertyAddress is null 

--Breaking out Address into Individual Columns (Address, City, State)
SELECT	PropertyAddress
FROM first_portfolio_project
--ORDER BY ParcelID

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1) AS Address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 2, LEN(PropertyAddress)) AS Address
FROM first_portfolio_project -- this code cuts the propertyaddress 
-- the CHARINDEX is actually a position (it indicates the position of the comma)

ALTER TABLE first_portfolio_project
Add PropertySplitAddress Nvarchar(255);

Update first_portfolio_project
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1)

ALTER TABLE first_portfolio_project
Add PropertySplitCity Nvarchar(255);

Update first_portfolio_project
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 2, LEN(PropertyAddress))


--Separating the OwnerAddress
SELECT OwnerAddress 
FROM first_portfolio_project

SELECT
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
FROM first_portfolio_project --the PARSNAME works the same way as SUBSTRING
--but it uses the unique delimiter '.' and it counts backwards
--this code splits the owner's address into 3

ALTER TABLE first_portfolio_project
Add OwnerSplitAddress Nvarchar(255);

UPDATE first_portfolio_project
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)

ALTER TABLE first_portfolio_project
Add OwnerSplitCity Nvarchar(255);

UPDATE first_portfolio_project
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)

ALTER TABLE first_portfolio_project
Add OwnerSplitState Nvarchar(255);

UPDATE first_portfolio_project
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)

---------------------------------------------------------------------------------------
--Change Y and N to Yes and No in "Sold as Vacant" field

SELECT DISTINCT(SoldAsVacant), count(SoldAsVacant)
FROM first_portfolio_project
group by SoldAsVacant
order by 2

SELECT SoldAsVacant, 
CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	 WHEN SoldAsVacant = 'N' THEN 'No'
ELSE SoldAsVacant
END 
FROM first_portfolio_project
WHERE SoldAsVacant = 'Y' or SoldAsVacant = 'n'

UPDATE first_portfolio_project
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
						WHEN SoldAsVacant = 'N' THEN 'No'
ELSE SoldAsVacant
END 

SELECT *
FROM first_portfolio_project
where SoldAsVacant = 'N' or SoldAsVacant = 'Y'


-----------------------------------------------------------------------------------------
--Remove Duplicates 
WITH RowNumCTE AS(
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY ParcelID,
			 PropertyAddress,
			 SalePrice,
			 SaleDate,
			 LegalReference
			 ORDER BY 
			 UniqueID
			 ) row_num
FROM first_portfolio_project
--ORDER BY ParcelID
)

SELECT *
FROM RowNumCTE
Where row_num > 1


---------------------------------------------------------------------------------------------

--Delete Unused Columns
SELECT *
FROM first_portfolio_project

ALTER TABLE first_portfolio_project
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress
-- this code removed the OwnerAddress, TaxDistrict and PropertyAddress columns

ALTER TABLE first_portfolio_project
DROP COLUMN SaleDate
-- removed the SaleDate column
