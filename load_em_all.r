source("smooth_operator.r")
source("load_single_group_member.r")

##
# groups is an array of the groups you want,
# Members is the members you want for each group rep(1:100) should do
##
loadEmAll <- function(groups,members, dpi, folder) {
    dataset = FALSE
    for(group in groups){
        print(paste0("Group: ", group))
        for(member in members){
            print(paste0("Member: ", member))
            member_data <- loadSinglePersonsData(dpi, paste0("group",group), member, folder);
            if(is.matrix(member_data)){
                print(paste0("Member: ", member, " success"))
            } else {
                print(paste0("Member: ", member, " failed"))
                break
            }
            
            if(is.matrix(dataset)){
                dataset <- rbind(dataset, member_data)
            } else {
                dataset = member_data
            }
        }
    }
    return(dataset)
}