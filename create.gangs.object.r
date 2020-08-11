# ##################### #
# create.gangs.object.R #
# ##################### #

# This program takes the files from the The Special Youth Project Affiliation Data website and constructs a network from those files.
# The files downloaded are:
	# http://www.jacobtnyoung.com/uploads/2/3/4/5/23459640/edgelist.bipartite.gangs.csv
	# http://www.jacobtnyoung.com/uploads/2/3/4/5/23459640/event.date.csv
	# http://www.jacobtnyoung.com/uploads/2/3/4/5/23459640/actor.attr.csv

# Load the appropriate packages.
library(network) #note: use install.packages("network") if you have not already installed the network package.
library(sna) #note: use install.packages("sna") if you have not already installed the sna package.

# Read in the edgelist.
gangs.edgelist <-read.csv("http://www.jacobtnyoung.com/uploads/2/3/4/5/23459640/edgelist.bipartite.gangs.csv",header=TRUE,as.is=TRUE)

#Check the data.
length(unique(gangs.edgelist[,1])) #number of individuals (first mode nodes).
length(unique(gangs.edgelist[,2])) #number of cards (second mode nodes).

# Create a network object from the edgelist.
gangs.network <- network(sort(gangs.edgelist),matrix.type="edgelist",directed=FALSE,bipartite=length(unique(gangs.edgelist[,1])))
gangs.network

# Now assign the event date information to the network object.
event.data <- read.csv("http://www.jacobtnyoung.com/uploads/2/3/4/5/23459640/event.date.csv",header=TRUE,as.is=TRUE)
set.vertex.attribute(gangs.network,"event.date",event.data[,2])

# Now assign the actor informaiton to the network object.
actor.data <- read.csv("http://www.jacobtnyoung.com/uploads/2/3/4/5/23459640/actor.attr.csv",header=TRUE,as.is=TRUE)
set.vertex.attribute(gangs.network,"gang.id",actor.data[,2])
set.vertex.attribute(gangs.network,"male"   ,actor.data[,3])
set.vertex.attribute(gangs.network,"white"  ,actor.data[,4])

# ########### #
# END PROGRAM #
# ########### #